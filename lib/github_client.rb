require 'octokit'

class GithubClient
  def connection
    Octokit::Client.new(access_token: ENV.fetch('GITHUB_API_TOKEN'))
  end

  def fetch_org_info(name)
    connection.org(name)
  rescue Octokit::NotFound
    return false
  end

  def fetch_org_member_list(org_name)
    org = connection.org(org_name)
    org.rels[:public_members].get.data
  end

  def parse_member_languages(member_name)
    member = connection.user(member_name)
    repos = member.rels[:repos].get.data
    repos.each do |repo|
      next if repo.fork
      languages.merge!(repo.rels[:languages].get.data) { |key, old_val, new_val| new_val + old_val }
    end
    languages
  end
end
