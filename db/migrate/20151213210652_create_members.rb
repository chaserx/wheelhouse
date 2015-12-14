class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.string :github_login
      t.integer :github_id
      t.string :avatar_url
      t.string :profile_url
      t.datetime :last_fetched_at
      t.timestamps null: false
    end
  end
end
