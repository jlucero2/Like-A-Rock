class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :x
      t.integer :y
      t.references :image
      t.references :user
      
      t.timestamps
    end
    add_index :tags, :image_id
    add_index :tags, :user_id
  end
end
