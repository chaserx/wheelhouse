class OrganizationsController < ApplicationController
  # GET /organizations/new
  def new
    @organization = Organization.new
  end

  # POST /organizations
  def create
    org_name = params[:organization][:name].downcase
    @organization = Organization.find_or_initialize_by(name: org_name)
    @client = GithubClient.new
    if @organization.new_record? # or record is outdated
      data = @client.fetch_org_info(@organization.name)
      if @organization.set_github_attrs(data)
        if @organization.save
          grab_members(@organization)
          flash[:notice] = "We're busy gathering data from GitHub." +
                           ' This might take a while. You may want to ' +
                           'Refresh often.'
          redirect_to @organization
        else
          save_failed
        end
      else
        not_found
      end
    else
      redirect_to @organization
    end
  end

  # GET /organizations/1
  # GET /organizations/openlexington
  def show
    @organization = Organization.friendly.find(params[:id])
    if params[:sort]
      @members = @organization.members.includes(:languages).
                 order("languages.name = \'#{params[:sort]}\' DESC,
                                     languages.bytes DESC")
    else
      @members = @organization.members
    end
  end

  private

  def not_found
    flash[:alert] = 'Sorry. We could not find or create organization:' \
                    " #{params[:organization][:name]}"
    redirect_to root_path
  end

  def save_failed
    flash[:alert] = 'Failed to create organization: ' +
                      @organization.errors.full_messages.join(', ')
    redirect_to root_path
  end

  def grab_members(org)
    @client = GithubClient.new
    @members = @client.fetch_org_member_list(org.login)
    @members.each do |member_data|
      member_args = { github_login: member_data.login }
      member = Member.find_or_initialize_by(member_args)
      if member.new_record? # or member record outdated
        member.set_github_attrs(member_data)
        member.organizations << org
        member.save
        SkillFetcherJob.perform_later(member.id)
      end
    end
  end
end
