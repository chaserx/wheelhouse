class Member < ActiveRecord::Base
  has_and_belongs_to_many :organizations, -> { uniq }
  has_many :languages

  def set_github_attrs(member_info)
    self.github_login = member_info[:login]
    self.github_id = member_info[:id]
    self.avatar_url = member_info[:avatar_url]
    self.profile_url = member_info[:html_url]
    self.last_fetched_at = Time.zone.now
  end

  def stale?
    Time.zone.now.to_i - updated_at.to_i > 30.seconds.to_i
  end
end
