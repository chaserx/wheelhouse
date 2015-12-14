class MembersOrganizationsJoinTable < ActiveRecord::Migration
  def change
    create_table :members_organizations, id: false do |t|
      t.belongs_to :member, index: true
      t.belongs_to :organization, index: true
    end
  end
end
