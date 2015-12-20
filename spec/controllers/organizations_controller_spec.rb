require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do
  describe 'GET #new' do
    let(:make_request) do
      get :new
    end

    before { make_request }

    it 'has ok status' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'non-existant organization' do
    end

    context 'with a new organization' do
      let(:make_request) do
        VCR.use_cassette('github_organization') do
          post :create, organization: { name: 'openlexington' }
        end
      end

      it 'it assigns organization with a name' do
        make_request
        expect(assigns(:organization).name).to eq('openlexington')
      end

      it 'creates a new organization record' do
        expect { make_request }.to change(Organization, :count).by(1)
      end

      it 'creates organization members' do
        expect { make_request }.to change(Member, :count).by(12)
      end

      it 'creates new language for workers' do
        expect { make_request }.to change(Language, :count)
      end

      it 'redirects user to organization show page' do
        make_request
        expect(response).to have_http_status(:redirect)
        expect(response.location).to match('/openlexington')
      end
    end

    context 'with an existing organziation' do
      let!(:org) { create(:organization) }
      let(:member) { create(:mamber, organization: org) }
      let(:make_request) do
        post :create, organization: { name: org.name }
      end

      it 'assigns organization with a name' do
        make_request
        expect(assigns(:organization).name).to eq(org.name)
      end

      it 'does not create a new organization' do
        expect { make_request }.not_to change(Organization, :count)
      end

      it 'does not create a new member' do
        expect { make_request }.not_to change(Member, :count)
      end

      it 'redirects user to organization show page' do
        make_request
        expect(response).to have_http_status(:redirect)
        expect(response.location).to match("/#{org.name}")
      end
    end
  end

  describe 'GET #show' do
    let(:org) { create(:organization) }
    let(:make_request) do
      get :show, id: org.id
    end

    before { make_request }

    it 'has ok status' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders show template' do
      expect(response).to render_template(:show)
    end
  end
end
