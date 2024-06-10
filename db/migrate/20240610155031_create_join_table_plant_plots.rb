class CreateJoinTablePlantPlots < ActiveRecord::Migration[7.1]
  def change
    create_join_table :plants, :plots do |t|
      t.index :plant_id
      t.index :plot_id
    end
  end
end
