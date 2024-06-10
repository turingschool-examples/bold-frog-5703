class Plant < ApplicationRecord
  has_many :plots, through: :plants_plots
end