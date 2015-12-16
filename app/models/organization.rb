class Organization < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true
  # githubid should be uniq
  has_and_belongs_to_many :members

  def set_github_attrs(org_info)
    self.login = org_info[:login]
    self.github_id = org_info[:id]
    self.avatar_url = org_info[:avatar_url]
    self.html_url = org_info[:html_url]
    self.last_fetched_at = Time.zone.now
  end
end
