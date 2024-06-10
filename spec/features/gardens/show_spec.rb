require "rails_helper"

RSpec.describe Garden do
  before(:each) do
    @garden1 = Garden.create!(name: "Turing Community Garden", organic: true)

    @plot1 = Plot.create!(number: 11, size: "Large", direction: "East", garden: @garden1)
    @plot2 = Plot.create!(number: 22, size: "Medium", direction: "North", garden: @garden1)
    @plot3 = Plot.create!(number: 33, size: "Small", direction: "West", garden: @garden1)

    @plant1 = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
    @plant2 = Plant.create!(name: "Avocado", description: "Makes great toast.", days_to_harvest: 34)
    @plant3 = Plant.create!(name: "Onion", description: "Goes great on a burger.", days_to_harvest: 55)
    @plant4 = Plant.create!(name: "Zucchini", description: "Tastes good when roasted", days_to_harvest: 19)
    @plant5 = Plant.create!(name: "Tomatoe", description: "So essential on a sandwich", days_to_harvest: 120)

    @plotplant1 = PlotPlant.create!(plot: @plot1, plant: @plant1)
    @plotplant2 = PlotPlant.create!(plot: @plot1, plant: @plant2)
    @plotplant3 = PlotPlant.create!(plot: @plot2, plant: @plant3)
    @plotplant4 = PlotPlant.create!(plot: @plot2, plant: @plant4)
    @plotplant5 = PlotPlant.create!(plot: @plot3, plant: @plant1)
    @plotplant6 = PlotPlant.create!(plot: @plot3, plant: @plant4)

    visit "/gardens/#{@garden1.id}"
  end

  #   User Story 3, Garden's Plants

  # As a visitor
  # [x]When I visit a garden's show page ('/gardens/:id')
  # [x]Then I see a list of plants that are included in that garden's plots
  # [x]And I see that this list is unique (no duplicate plants)
  # [x]And I see that this list only includes plants that take less than 100 days to harvest

  it 'shows plants that take less than 100 days to harvest' do
    expect(page).to have_content(@plant1.name, count:1)
    expect(page).to have_content(@plant2.name, count:1)
    expect(page).to have_content(@plant3.name, count:1)
    expect(page).to have_content(@plant4.name, count:1)

    expect(page).to_not have_content(@plant5.name)

  end
end