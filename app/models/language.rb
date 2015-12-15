class Language < ActiveRecord::Base
  belongs_to :member
  validates :name, presence: true
end
