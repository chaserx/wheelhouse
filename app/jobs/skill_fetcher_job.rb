class SkillFetcherJob < ActiveJob::Base
  queue_as :default

  def perform(member_id)
    @member = Member.find(member_id)
    languages = GithubClient.new.fetch_member_languages(@member.github_login)
    languages.each do |name, bytes|
      language = @member.languages.find_or_initialize_by(name: name)
      language.bytes = bytes
      language.save
    end
  end
end
