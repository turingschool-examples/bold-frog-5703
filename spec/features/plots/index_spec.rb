require "rails_helper"

RSpec.describe "Plots Index Page" do
# User Story 1 - Plots Index Page
# As a visitor
# When I visit the plots index page ('/plots')
# I see a list of all plot numbers
# And under each plot number I see the names of all that plot's plants
  before(:each) do
    @garden = Garden.create(name: "Eden", organic: true)

    @plot = @garden.plots.create!(number: 25, size: "Large", direction: "East", garden: @garden)
    @plot2 = @garden.plots.create!(number: 26, size: "Small", direction: "West", garden: @garden)

    @plant = Plant.create(name: "Apple", description: "Red Delicious", days_to_harvest: 90)
    @plant2 = Plant.create(name: "Strawberry", description: "Juicy and Sweet", days_to_harvest: 70)

    PlotPlant.create!(plot: @plot, plant: @plant)
  end
  describe "As a visitor" do
    it "when I visit the plots index page, I see all of the plot numbers" do
      visit "/plots"
      
      save_and_open_page
      # expect(page).to have_content(@plot.number)
      # expect(page).to have_content(@plot2.number)
    end
    xit "when I visit the plots index page, under each plot number I see the names of all the plot's plants" do

    end
  end
end