class Organization < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_and_belongs_to_many :members
  validates :name, presence: true

  def set_github_attrs(org_info)
    return false if org_info == false
    self.login = org_info[:login]
    self.github_id = org_info[:id]
    self.avatar_url = org_info[:avatar_url]
    self.html_url = org_info[:html_url]
    self.last_fetched_at = Time.zone.now
  end
end
