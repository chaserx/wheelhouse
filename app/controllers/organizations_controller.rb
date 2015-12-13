class OrganizationsController < ApplicationController
  # GET /organizations/new
  def new
    @organization = Organization.new
  end

  # POST /organizations
  def create
    org_name = params[:organization][:name].downcase
    @organization = Organization.find_or_initialize_by(name: org_name)

    if @organization.new_record?
      if data=Organization.fetch_org_info(@organization.name)
        if @organization.set_github_attrs(data)
          if @organization.save
            # maybe start job of finding members and their skillz
            redirect_to @organization
          else
            not_found
          end
        else
          not_found
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
