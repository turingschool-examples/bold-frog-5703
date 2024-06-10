class FixTypoPlant < ActiveRecord::Migration[7.1]
  def change
    rename_column :plants, :day_to_harvest, :days_to_harvest
  end
end
