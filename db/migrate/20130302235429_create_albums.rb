class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :url
      t.integer :sol
      t.string :timestamp
      t.integer :num_images

      t.timestamps
    end
  end
end
