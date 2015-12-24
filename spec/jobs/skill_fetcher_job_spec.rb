require 'rails_helper'

RSpec.describe SkillFetcherJob, type: :job do
  describe '#fetch_org_info' do
    let(:make_request) {
      ->{
        VCR.use_cassette('github_organization') do
          GithubClient.new.fetch_org_info('openlexington')
        end
      }
    }

    it 'returns a resource' do
      expect(make_request.call).to be_a(Sawyer::Resource)
    end

    it 'contains openlexington as the login' do
      expect(make_request.call.login).to eq('openlexington')
    end
  end

  describe '#fetch_org_member_list' do
    let(:make_request) {
      ->{
        VCR.use_cassette('github_organization') do
          GithubClient.new.fetch_org_member_list('openlexington')
        end
      }
    }

    it 'returns an array' do
      expect(make_request.call).to be_a(Array)
    end

    it 'returns an array of members' do
      expect(make_request.call.count).not_to eq(0)
    end
  end

  describe '#fetch_member_languages' do
    let(:make_request) {
      ->{
        VCR.use_cassette('chaserx') do
          GithubClient.new.fetch_member_languages('chaserx')
        end
      }
    }

    it 'returns a hash' do
      expect(make_request.call).to be_a(Hash)
    end

    it 'returns a hash with language keys and byte values' do
      expected_hsh = {:Ruby => 969926, :JavaScript => 959973, :CSS => 264713,
                      :HTML => 63030, :VimL => 17709, :Swift => 12933,
                      :CoffeeScript => 12107, :"Objective-C" => 9824,
                      :Shell => 6939, :Arduino => 6044, :OpenSCAD => 2306,
                      :PHP => 269}
      expect(make_request.call).to eq(expected_hsh)
    end
  end
end
