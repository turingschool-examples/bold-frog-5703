class Plot < ApplicationRecord
   belongs_to :garden
   has_many :plots_plants
   has_many :plants, through: :plots_plants
end