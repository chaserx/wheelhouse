class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :login
      t.integer :github_id
      t.string :avatar_url
      t.string :html_url
      t.boolean :fetched_users, default: false, null: false
      t.timestamp :last_fetched_at
      t.timestamps null: false
    end
  end
end
