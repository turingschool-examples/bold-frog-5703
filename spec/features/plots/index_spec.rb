require "rails_helper"

RSpec.describe "plots index" do
  it "should have a list of all plot numbers and display the names of all that plot's plants under each plot" do
    garden_1 = Garden.create!(name: "Turing Community Garden", organic: true)
    plot_1 = Plot.create!(number: 1, size: "Large", direction: "East", garden_id: garden_1.id)
    plot_2 = Plot.create!(number: 2, size: "Medium", direction: "West", garden_id: garden_1.id)
    plant_1 = Plant.create!(name: "Rose", description: "smells good", days_to_harvest: 10)
    plant_2 = Plant.create!(name: "Tulip", description: "looks nice", days_to_harvest: 20)
    plant_3 = Plant.create!(name: "Pepper", description: "tastes good", days_to_harvest: 30)
    PlotPlant.create!(plot: plot_1, plant: plant_1)
    PlotPlant.create!(plot: plot_1, plant: plant_2)
    PlotPlant.create!(plot: plot_2, plant: plant_3)

    visit plots_path

    within("#plot-#{plot_1.id}") do
      expect(page).to have_content(plot_1.number)
      expect(page).to have_content(plant_1.name)
      expect(page).to have_content(plant_2.name)

      expect(page).to_not have_content(plant_3.name)
    end

    within("#plot-#{plot_2.id}") do
      expect(page).to have_content(plot_2.number)
      expect(page).to have_content(plant_3.name)

      expect(page).to_not have_content(plant_1.name)
      expect(page).to_not have_content(plant_2.name)
    end
  end

  it "should have a button next to each plant's name to remove that plant from that plot" do
    garden_1 = Garden.create!(name: "Turing Community Garden", organic: true)
    plot_1 = Plot.create!(number: 1, size: "Large", direction: "East", garden_id: garden_1.id)
    plot_2 = Plot.create!(number: 2, size: "Medium", direction: "West", garden_id: garden_1.id)
    plant_1 = Plant.create!(name: "Rose", description: "smells good", days_to_harvest: 10)
    plant_2 = Plant.create!(name: "Tulip", description: "looks nice", days_to_harvest: 20)
    plant_3 = Plant.create!(name: "Pepper", description: "tastes good", days_to_harvest: 30)
    PlotPlant.create!(plot: plot_1, plant: plant_1)
    PlotPlant.create!(plot: plot_1, plant: plant_2)
    PlotPlant.create!(plot: plot_2, plant: plant_3)

    visit plots_path

    within("#plant-#{plant_1.id}") do
      click_button "Delete"
    end

    expect(page).to_not have_content("Rose")
  end

end