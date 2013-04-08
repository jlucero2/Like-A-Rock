class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.text :body
      t.text :url
      t.references :admin
      t.references :image

      t.timestamps
    end
    add_index :responses, :admin_id
    add_index :responses, :image_id
  end
end
