class Garden < ApplicationRecord
   has_many :plots
   has_many :plants, through: :plots

   def plants_filtered
      plants.where("plants.days_to_harvest < 100").distinct
   end
end