class CreatePlants < ActiveRecord::Migration[7.1]
  def change
    create_table :plants do |t|
      t.string :name
      t.string :description
      t.integer :day_to_harvest

      t.timestamps
    end
  end
end
