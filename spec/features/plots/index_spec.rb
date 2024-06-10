require "rails_helper"

RSpec.describe "Plots Index Page" do
  describe "User Story 1" do
    describe "As a visitor, when i visit the plots index page" do
      it "shows a list of all plot numbers" do
        garden = Garden.create!(name: "Turing Community Garden", organic: true)
        plot_1 = Plot.create!(number: 25, size: "Large", direction: "East", garden_id: garden.id)
        plant_1 = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
        plant_2 = Plant.create!(name: "Plant 2", description: "Awesome Plant", days_to_harvest: 50)

        plot_2 = Plot.create!(number: 26, size: "Medium", direction: "West", garden_id: garden.id)
        plant_3 = Plant.create!(name: "BEANS", description: "Great beans happen here.", days_to_harvest: 60)

        PlotPlant.create!(plot_id: plot_1.id, plant_id: plant_1.id)
        PlotPlant.create!(plot_id: plot_1.id, plant_id: plant_2.id)
        PlotPlant.create!(plot_id: plot_2.id, plant_id: plant_3.id)

        visit plots_path

        within(".list_plot_numbers_and_plant_names") do
          expect(page).to have_content("Plot Number: 25")
          expect(page).to have_content("Plot Number: 26")
        end
      end
  
      it "shows the names of all the plot's plants under each plot number" do
        garden = Garden.create!(name: "Turing Community Garden", organic: true)
        plot_1 = Plot.create!(number: 25, size: "Large", direction: "East", garden_id: garden.id)
        plant_1 = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
        plant_2 = Plant.create!(name: "Plant 2", description: "Awesome Plant", days_to_harvest: 50)

        plot_2 = Plot.create!(number: 26, size: "Medium", direction: "West", garden_id: garden.id)
        plant_3 = Plant.create!(name: "BEANS", description: "Great beans happen here.", days_to_harvest: 60)

        PlotPlant.create!(plot_id: plot_1.id, plant_id: plant_1.id)
        PlotPlant.create!(plot_id: plot_1.id, plant_id: plant_2.id)
        PlotPlant.create!(plot_id: plot_2.id, plant_id: plant_3.id)

        visit plots_path

        within(".list_plot_numbers_and_plant_names") do
          expect(page).to have_content("Plant Name: Purple Beauty Sweet Bell Pepper")
          expect(page).to have_content("Plant Name: BEANS")
        end
      end
    end
  end
end