class Plot < ApplicationRecord
   belongs_to :garden
   has_many :plants, through: :plants_plots
end