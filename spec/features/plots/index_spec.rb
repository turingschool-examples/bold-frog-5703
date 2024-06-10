require "rails_helper"

RSpec.describe "plots index" do
  it "should have a list of all plot numbers and display the names of all that plot's plants under each plot" do
    garden_1 = Garden.create!(name: "Turing Community Garden", organic: true)
    plot_1 = garden1.plot.create!(number: 1, size: "Large", direction: "East")
    plot_2 = garden1.plot.create!(number: 2, size: "Medium", direction: "West")
    plant_1 = Plant.create!(name: "Rose", description: "smells good", days_to_harvest: 10)
    plant_2 = Plant.create!(name: "Tulip", description: "looks nice", days_to_harvest: 20)
    plant_3 = Plant.create!(name: "Pepper", description: "tastes good", days_to_harvest: 30)
    PlotPlant.create!(plot: plot_1, plant: plant_1)
    PlotPlant.create!(plot: plot_1, plant: plant_2)
    PlotPlant.create!(plot: plot_2, plant: plant_3)

    visit 
  end
end