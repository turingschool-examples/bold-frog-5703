class Garden < ApplicationRecord
   has_many :plots


   def under_100_day_plants
# FROM Plants to gardens I need to run through all tables. Multiple JOIN
# WHERE days_to_harvest < 100
# SELECT plant.name, plant.days_to_harvest
# DISTINCT Plant.name

   end
end