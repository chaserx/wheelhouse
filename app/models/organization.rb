require 'octokit'

class Organization < ActiveRecord::Base
  validates :name, presence: true
  # githubid should be uniq

  # TODO(chaserx): this could probably be in its own lib file
  def self.fetch_org_info(name)
    client = Octokit::Client.new(access_token: ENV.fetch('GITHUB_API_TOKEN'))
    client.org(name)
  rescue Octokit::NotFound
    return false
  end

  def set_github_attrs(org_info)
    self.login = org_info[:login]
    self.github_id = org_info[:id]
    self.avatar_url = org_info[:avatar_url]
    self.html_url = org_info[:html_url]
    self.last_fetched_at = Time.zone.now
  end
end
