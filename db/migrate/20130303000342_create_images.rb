class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :urlList
      t.string :sol
      t.references :album
      t.integer :votes_count, :default => 0
      t.integer :responses_count, :default => 0
      t.string :bucket
      t.string :cameraModelComponentList
      t.string :dateAdded
      t.string :filterName
      t.string :pdsLabelUrl
      t.string :scaleFactor
      t.string :sclk
      t.string :attitude
      t.string :cameraPosition
      t.string :contributor
      t.string :drive
      t.string :cameraModelType
      t.string :mastAz
      t.string :site
      t.string :cameraVector
      t.string :itemName
      t.string :subframeRect
      t.string :utc
      t.string :mastEl
      t.string :instrument
      t.string :lmst
      t.string :sampleType
      t.string :xyz

      t.timestamps
    end
    add_index :images, :album_id
  end
end
