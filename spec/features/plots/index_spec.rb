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

        within(".list_plot_numbers_#{plot_1.number}") do
          expect(page).to have_content("Plot Number: 25")
        end

        within(".list_plot_numbers_#{plot_2.number}") do
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

        within(".list_plot_numbers_#{plot_1.number}") do
          expect(page).to have_content("Plant Name: Purple Beauty Sweet Bell Pepper")
          expect(page).to have_content("Plant Name: Plant 2")
        end

        within(".list_plot_numbers_#{plot_2.number}") do
          expect(page).to have_content("Plant Name: BEANS")
          save_and_open_page
        end
      end
    end
  end

  describe "User Story 2" do
    describe "As a visitor, when i visit the plots index page" do
      it "shows a button next to each plant's name to remove that plant from that plot" do
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

        within(".list_plot_numbers_#{plot_1.number}") do
          expect(page).to have_button("Remove #{plant_2.name} from Plot #{plot_1.number}")
        end
      end
      
      it "directs back to the plots index page" do
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
        
        within(".list_plot_numbers_#{plot_1.number}") do
          click_button("Remove #{plant_2.name} from Plot #{plot_1.number}")
        end
        
        expect(current_path).to eq(plots_path)
      end

      it "no longer shows that plant listed under that plot" do
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

        
        visit plots_path
        
        within(".list_plot_numbers_#{plot_1.number}") do
          click_button("Remove #{plant_2.name} from Plot #{plot_1.number}")

          expect(page).to_not have_content("Plant Name: Plant 2")
        end
      end


      it "still shows the removed plant's name under other plots that it was associated with" do
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

        
        visit plots_path

        within(".list_plot_numbers_#{plot_1.number}") do
        click_button("Remove #{plant_2.name} from Plot #{plot_1.number}")

        expect(page).to_not have_content("Plant Name: Plant 2")
      end

        within(".list_plot_numbers_#{plot_2.number}") do
          expect(page).to have_content("Plant Name: Plant 2")
        end
      end
    end
  end
end