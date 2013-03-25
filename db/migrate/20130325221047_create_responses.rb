class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.text :body
      t.references :admin
      t.references :image

      t.timestamps
      add_index :votes, :admin_id
      add_index :votes, :image_id
    end
  end
end
