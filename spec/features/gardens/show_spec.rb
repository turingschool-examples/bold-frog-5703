require "rails_helper"

RSpec.describe "Gardens Show Page" do
  before(:each) do
    @garden = Garden.create(name: "Eden", organic: true)

    @plot = Plot.create!(number: 25, size: "Large", direction: "East", garden_id: @garden.id)
    @plot2 = Plot.create!(number: 26, size: "Small", direction: "West", garden_id: @garden.id)

    @plant = Plant.create(name: "Apple", description: "Red Delicious", days_to_harvest: 100)
    @plant2 = Plant.create(name: "Strawberry", description: "Juicy and Sweet", days_to_harvest: 70)

    @plot_plant = PlotPlant.create!(plot: @plot, plant: @plant)
    @plot_plant2 = PlotPlant.create!(plot: @plot2, plant: @plant2)
  end
  # User Story 3 - Garden's Plants
  # As a visitor
  # When I visit a garden's show page ('/gardens/:id')
  # Then I see a list of plants that are included in that garden's plots
  # And I see that this list is unique (no duplicate plants)
  # And I see that this list only includes plants that take less than 100 days to harvest 
  it "displays a list of the plants included in the gardens plots" do
    visit "/gardens/#{@garden.id}"
    save_and_open_page
    expect(page).to have_content(@plant2.name)
  end 
end