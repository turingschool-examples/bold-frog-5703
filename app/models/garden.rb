class Garden < ApplicationRecord
   has_many :plots

   def harvests_in_less_than_100_days
      Plant.joins(:plots)
         .where('plots.garden_id = ?', id)
         .where('plants.days_to_harvest < 100')
         .distinct
   end
end