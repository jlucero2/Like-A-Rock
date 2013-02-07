class CreateDeohtests < ActiveRecord::Migration
  def change
    create_table :deohtests do |t|

      t.timestamps
    end
  end
end
