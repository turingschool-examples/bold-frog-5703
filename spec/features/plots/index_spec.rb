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

    it "shows all plot numbers and plants" do
        visit plots_path

        expect(page).to have_content("Plot Number: 1")
        expect(page).to have_content("Tomato")
        expect(page).to have_content("Carrot")

        expect(page).to have_content("Plot Number: 2")
        expect(page).to have_content("Tomato")
    end
end