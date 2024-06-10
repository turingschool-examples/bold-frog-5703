require "rails_helper"

RSpec.describe "Gardens Show Page" do
  describe "User Story 3" do
    describe "As a visitor, when I visit a garden's show page" do
      it "shows a list of plants that are included in the garden's plots" do
        garden = Garden.create!(name: "Turing Community Garden", organic: true)
        plot_1 = Plot.create!(number: 25, size: "Large", direction: "East", garden_id: garden.id)
        plant_1 = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
        plant_2 = Plant.create!(name: "Plant 2", description: "Awesome Plant", days_to_harvest: 50)

        plot_2 = Plot.create!(number: 26, size: "Medium", direction: "West", garden_id: garden.id)
        plant_3 = Plant.create!(name: "BEANS", description: "Great beans happen here.", days_to_harvest: 60)

        PlotPlant.create!(plot_id: plot_1.id, plant_id: plant_1.id)
        PlotPlant.create!(plot_id: plot_1.id, plant_id: plant_2.id)
        PlotPlant.create!(plot_id: plot_2.id, plant_id: plant_3.id)

        visit garden_path(garden)

        within(".garden_plants_list") do
          expect(page).to have_content("Plant Name: Purple Beauty Sweet Bell Pepper")
          expect(page).to have_content("Plant Name: Plant 2")
          expect(page).to have_content("Plant Name: BEANS")
        end
      end

      it "shows that this list of plants is unique" do
        garden = Garden.create!(name: "Turing Community Garden", organic: true)
        plot_1 = Plot.create!(number: 25, size: "Large", direction: "East", garden_id: garden.id)
        plant_1 = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
        plant_2 = Plant.create!(name: "Plant 2", description: "Awesome Plant", days_to_harvest: 50)

        plot_2 = Plot.create!(number: 26, size: "Medium", direction: "West", garden_id: garden.id)
        plant_3 = Plant.create!(name: "BEANS", description: "Great beans happen here.", days_to_harvest: 60)

        PlotPlant.create!(plot_id: plot_1.id, plant_id: plant_1.id)
        PlotPlant.create!(plot_id: plot_1.id, plant_id: plant_2.id)
        PlotPlant.create!(plot_id: plot_2.id, plant_id: plant_3.id)
        PlotPlant.create!(plot_id: plot_2.id, plant_id: plant_2.id)

        visit garden_path(garden)

        within(".garden_plants_list") do
          expect(page).to have_content("Plant Name: Purple Beauty Sweet Bell Pepper")
          expect(page).to have_content("Plant Name: Plant 2")
          expect(page).to have_content("Plant Name: BEANS")
        end
      end

      it "shows that this list only includes plants that take less than 100 days to harvest" do
        garden = Garden.create!(name: "Turing Community Garden", organic: true)
        plot_1 = Plot.create!(number: 25, size: "Large", direction: "East", garden_id: garden.id)
        plant_1 = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
        plant_2 = Plant.create!(name: "Plant 2", description: "Awesome Plant", days_to_harvest: 50)

        plot_2 = Plot.create!(number: 26, size: "Medium", direction: "West", garden_id: garden.id)
        plant_3 = Plant.create!(name: "BEANS", description: "Great beans happen here.", days_to_harvest: 60)
        plant_4 = Plant.create!(name: "Plant 4", description: "Plant 4 takes too long.", days_to_harvest: 101)

        PlotPlant.create!(plot_id: plot_1.id, plant_id: plant_1.id)
        PlotPlant.create!(plot_id: plot_1.id, plant_id: plant_2.id)
        PlotPlant.create!(plot_id: plot_2.id, plant_id: plant_3.id)
        PlotPlant.create!(plot_id: plot_2.id, plant_id: plant_2.id)
        PlotPlant.create!(plot_id: plot_2.id, plant_id: plant_4.id)

        visit garden_path(garden)

        within(".garden_plants_list") do
          expect(page).to have_content("Plant Name: Purple Beauty Sweet Bell Pepper")
          expect(page).to have_content("Plant Name: Plant 2")
          expect(page).to have_content("Plant Name: BEANS")
        end
      end
    end
  end
end