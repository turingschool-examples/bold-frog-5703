require "rails_helper"

RSpec.describe "the gardens index" do
  before(:each) do
    @garden = Garden.create!(name: "Garden", organic: true )
    @plot1 = @garden.plots.create!(number: "1", size: "4x4", direction: "up" )
    @plot2 = @garden.plots.create!(number: "2", size: "4x4", direction: "down" )
    @plant1 = Plant.create!(name: "Carrot", description: "Orange carrot", days_to_harvest: 70)
    @plant2 = Plant.create!(name: "Cabbage", description: "Green cabbage", days_to_harvest: 110)
    @plant3 = Plant.create!(name: "Beet", description: "Purple beet", days_to_harvest: 90)
    @plot_plants = PlotPlant.create!(plot_id: @plot1.id, plant_id: @plant1.id)
    @plot_plants2 = PlotPlant.create!(plot_id: @plot1.id, plant_id: @plant2.id)
    @plot_plants3 = PlotPlant.create!(plot_id: @plot2.id, plant_id: @plant3.id)
    @plot_plants4 = PlotPlant.create!(plot_id: @plot1.id, plant_id: @plant3.id)
    visit "/gardens/#{@garden.id}"
  end
  # User Story 3, Garden's Plants
  # As a visitor
  # When I visit a garden's show page ('/gardens/:id')
  # Then I see a list of plants that are included in that garden's plots
  # And I see that this list is unique (no duplicate plants)
  # And I see that this list only includes plants that take less than 100 days to harvest
  it "can see list of unique plants from its garden that takes less than 100 day to harvest" do
    expect(page).to have_content("Plants: #{@plant1.name}, #{@plant3.name}")

    expect(page).to_not have_content(@plant2.name)
  end
end