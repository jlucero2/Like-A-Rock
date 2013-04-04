class AddEarthdayToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :earthday, :string
  end
end
