require "rails_helper"

RSpec.describe "Plots Index Page" do
    before :each do
        @garden = Garden.create!(name: "Turing Community Garden", organic: true)
        @plot1 = @garden.plots.create!(number: 1, size: "Large", direction: "East")
        @plot2 = @garden.plots.create!(number: 2, size: "Medium", direction: "West")
        @plant1 = Plant.create!(name: "Tomato",description: "Red and juicy", days_to_harvest: 50)
        @plant2 = Plant.create!(name: "Carrot",description: "Orange and crunchy", days_to_harvest: 30)

        PlotPlant.create!(plot: @plot1, plant: @plant1)
        PlotPlant.create!(plot: @plot1, plant: @plant2)
        PlotPlant.create!(plot: @plot2, plant: @plant1)
    end

    it "should shows all plot numbers and plants" do
        visit plots_path

        expect(page).to have_content("Plot Number: 1")
        expect(page).to have_content("Tomato")
        expect(page).to have_content("Carrot")

        expect(page).to have_content("Plot Number: 2")
        expect(page).to have_content("Tomato")
    end

    it "should remove a plant from a plot" do
        visit plots_path

        within("#plot-#{@plot1.id}") do
            within("#plant-#{@plant1.id}") do
                click_button "Remove"
            end
        end

        expect(current_path).to eq(plots_path)
        within("#plot-#{@plot.id}") do
            expect(page).to_not have_content("Tomato")
        end
        within("#plot-#{@plot2.id}") do
            expect(page).to have_content("Tomato")
        end
    end
end