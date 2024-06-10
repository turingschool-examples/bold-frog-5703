class Plant < ApplicationRecord
  belongs_to :plots
  has_many :plant_plots
  has_many :plots, through: :plant_plots
end