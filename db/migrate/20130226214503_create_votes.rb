class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user
      t.references :image

      t.timestamps
    end
    add_index :votes, :user_id
    add_index :votes, :image_id
  end
end
