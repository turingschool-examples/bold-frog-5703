class Garden < ApplicationRecord
   has_many :plots
   has_many :plants, through: :plots

   def under_100_day_plants
      # binding.pry
      plants.where("plants.days_to_harvest < 100").select(:name).distinct
   end
end