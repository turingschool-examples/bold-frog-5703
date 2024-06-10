class Garden < ApplicationRecord
   has_many :plots

   def plants_under_100_days
      plots.joins(:plants).where('days_to_harvest < 100').distinct.pluck(:name)
   end

   def plant_counter
      plots.joins(:plants)
         .group('plants.name')
         .select('plants.name, COUNT(plants.name) as count')
         .order('count DESC')
   end
end