class CreatePlantPlotsJoinTable < ActiveRecord::Migration[7.1]
  def change
    create_table :plant_plots, id: false do |t|
      t.references :plant, null: false, foreign_key: true
      t.references :plot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
