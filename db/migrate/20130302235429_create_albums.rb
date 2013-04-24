class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :url
      t.string :sol
      t.integer :num_images
      t.string :earthday

      t.timestamps
    end
  end
end
