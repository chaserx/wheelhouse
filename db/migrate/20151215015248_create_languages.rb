class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :name
      t.integer :bytes
      t.references :member, index: true
      t.timestamps null: false
    end
  end
end
