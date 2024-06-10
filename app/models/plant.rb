class Plant < ApplicationRecord
  has_many :plot_plants
  has_many :plots, through: :plot_plants

  def plot_plant_by_plot(plot_id)
    plot_plants.joins(:plot).where("plots.id = ?", plot_id).first
  end
end