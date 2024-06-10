class Garden < ApplicationRecord
   has_many :plots
   has_many :plants, through: :plots

   def plants_list
      plants.where("days_to_harvest < 100").distinct
   end

   def sorted_plants
      plants.where("days_to_harvest < 100")
            .select("plants.*, count(plots.id)")
            .group("plants.id")
            .order("count(plots.id) desc")
   end
end