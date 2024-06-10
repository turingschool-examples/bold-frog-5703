require "rails_helper"

RSpec.describe "Garden Show Page" do
    before :each do
        @garden = Garden.create!(name: "Turing Community Garden", organic: true)
        @plot1 = @garden.plots.create!(number: 1, size: "Large", direction: "East")
        @plot2 = @garden.plots.create!(number: 2, size: "Medium", direction: "West")
        @plant1 = Plant.create!(name: "Tomato", description: "Red and juicy", days_to_harvest: 50)
        @plant2 = Plant.create!(name: "Carrot", description: "Orange and crunchy", days_to_harvest: 30)
        @plant3 = Plant.create!(name: "Corn", description: "Yellow and sweet", days_to_harvest: 120)
        @plant4 = Plant.create!(name: "Pepper", description: "Hot and spicy", days_to_harvest: 90)

        PlotPlant.create!(plot: @plot1, plant: @plant1)
        PlotPlant.create!(plot: @plot1, plant: @plant2)
        PlotPlant.create!(plot: @plot2, plant: @plant1)
        PlotPlant.create!(plot: @plot2, plant: @plant4)
        PlotPlant.create!(plot: @plot2, plant: @plant3)
    end

    it "should show a unique list of plants that take less than 100 days to harvest" do
        visit garden_path(@garden)

        expect(page).to have_content("Tomato")
        expect(page).to have_content("Carrot")
        expect(page).to have_content("Pepper")
        expect(page).to_not have_content("Corn")

        within "#plants" do
            expect(page).to have_css("li", count: 3)
        end
    end
end