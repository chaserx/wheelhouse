FactoryGirl.define do
  factory :organization do
    name 'test-org'
    login 'testorg'
    github_id 1234
    avatar_url 'http://example.com'
    members { |e| [e.association(:member)] }
  end
end
