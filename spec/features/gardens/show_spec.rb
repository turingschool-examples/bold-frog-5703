require "rails_helper"

RSpec.describe "garden show" do
  it "should show distinct list of plants that are included in that garden's plots that take less than 100 days to harvest" do
    garden_1 = Garden.create!(name: "Turing Community Garden", organic: true)
    plot_1 = Plot.create!(number: 1, size: "Large", direction: "East", garden_id: garden_1.id)
    plot_2 = Plot.create!(number: 2, size: "Medium", direction: "West", garden_id: garden_1.id)
    plant_1 = Plant.create!(name: "Rose", description: "smells good", days_to_harvest: 10)
    plant_2 = Plant.create!(name: "Tulip", description: "looks nice", days_to_harvest: 20)
    plant_3 = Plant.create!(name: "Pepper", description: "tastes good", days_to_harvest: 130)
    plant_4 = Plant.create!(name: "Tulip", description: "looks nice", days_to_harvest: 20)

    PlotPlant.create!(plot: plot_1, plant: plant_1)
    PlotPlant.create!(plot: plot_1, plant: plant_2)
    PlotPlant.create!(plot: plot_1, plant: plant_3)
    PlotPlant.create!(plot: plot_2, plant: plant_4)

    visit garden_path(garden_1)

    expect(page).to have_content("Rose")
    expect(page).to have_content("Tulip")
  
    expect(page).to_not have_content("Pepper")
  end
end
