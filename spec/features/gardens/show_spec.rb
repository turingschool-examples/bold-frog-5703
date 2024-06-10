require "rails_helper"

RSpec.describe "Gardens Show Page" do
  before(:each) do
    @garden = Garden.create(name: "Eden", organic: true)
    @garden2 = Garden.create(name: "The Farm", organic: false)

    @plot = Plot.create!(number: 25, size: "Large", direction: "East", garden_id: @garden.id)
    @plot2 = Plot.create!(number: 26, size: "Small", direction: "West", garden_id: @garden.id)
    
    @plot3 = Plot.create!(number: 26, size: "Small", direction: "West", garden_id: @garden2.id)

    @plant = Plant.create(name: "Apple", description: "Red Delicious", days_to_harvest: 101)
    @plant2 = Plant.create(name: "Strawberry", description: "Juicy and Sweet", days_to_harvest: 70)
    @plant3 = Plant.create(name: "Cherry", description: "Tart and Sweet", days_to_harvest: 90)

    @plot_plant = PlotPlant.create!(plot: @plot, plant: @plant)
    @plot_plant2 = PlotPlant.create!(plot: @plot, plant: @plant2)
    @plot_plant3 = PlotPlant.create!(plot: @plot2, plant: @plant2)

    @plot_plant4 = PlotPlant.create!(plot: @plot3, plant: @plant2)
  end
  # User Story 3 - Garden's Plants
  # As a visitor
  # When I visit a garden's show page ('/gardens/:id')
  # Then I see a list of plants that are included in that garden's plots
  # And I see that this list is unique (no duplicate plants)
  # And I see that this list only includes plants that take less than 100 days to harvest 
  it "displays a list of the plants included in the gardens plots" do
    visit "/gardens/#{@garden.id}"
    # save_and_open_page

    expect(@garden.unique_plants).to eq([@plant2]) # this should be a model test

    within("#garden-#{@garden.id}") do
      expect(page).to_not have_content(@plant.name)
      expect(page).to have_content(@plant2.name)
    end

    expect(page).to have_content(@plant2.name, count: 1)
  end 
end