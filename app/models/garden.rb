class Garden < ApplicationRecord
  has_many :plots

  def unique_plants
    plots
      .joins(:plants)
      .select('plants.*')
      .where('plants.days_to_harvest <= ?', 100)
      .distinct
  end
end