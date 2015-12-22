class AddIndexToJoinTableForUniqueness < ActiveRecord::Migration
  def change
    add_index :members_organizations, [:member_id, :organization_id], unique: true
    add_index :members_organizations, [:organization_id, :member_id], unique: true
  end
end
