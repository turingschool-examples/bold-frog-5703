class Garden < ApplicationRecord
   has_many :plots

   def plants_under_100_days
      plots.joins(:plants).where('days_to_harvest < 100').distinct.pluck(:name)
   end

end