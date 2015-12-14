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
    if @organization.new_record? # or record is old
      if data=@client.fetch_org_info(@organization.name)
        if @organization.set_github_attrs(data)
          if @organization.save
            # maybe start job of finding members and their skillz
            @members = @client.fetch_org_member_list(@organization.login)
            @members.each do |member_data|
              member = Member.find_or_initialize_by(github_login: member_data.login)
              member.set_github_attrs(member_data)
              member.organizations << @organization
              member.save
            end
            redirect_to @organization
          else
            not_found # being lazy, but this is really could not save
          end
        else
          not_found # if data can be fetched, I'm not sure we get here unless it's real bad
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
    @organization = Organization.find(params[:id])
  end

  private

  def not_found
    flash[:alert] = "Sorry. We could not find or create organization: #{org_name}"
    redirect_to root_path
  end

end
