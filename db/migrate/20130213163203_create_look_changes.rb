class CreateLookChanges < ActiveRecord::Migration
  def change
    create_table :look_changes do |t|

      t.timestamps
    end
  end
end
