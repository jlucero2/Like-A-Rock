class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :url
      t.integer :sol
      t.references :album
      t.integer :votes_count, :default => 0

      t.timestamps
    end
    add_index :images, :album_id
  end
end
