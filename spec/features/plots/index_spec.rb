require "rails_helper"

RSpec.describe "Plots Index Page" do
  before(:each) do
    @garden = Garden.create(name: "Eden", organic: true)

    @plot = Plot.create!(number: 25, size: "Large", direction: "East", garden_id: @garden.id)
    @plot2 = Plot.create!(number: 26, size: "Small", direction: "West", garden_id: @garden.id)

    @plant = Plant.create(name: "Apple", description: "Red Delicious", days_to_harvest: 90)
    @plant2 = Plant.create(name: "Strawberry", description: "Juicy and Sweet", days_to_harvest: 70)

    @plot_plant = PlotPlant.create!(plot: @plot, plant: @plant)
  end
  
  it "when I visit the plots index page, I see all of the plot numbers" do
    visit "/plots"
    save_and_open_page
    within("#plots") do
      expect(page).to have_content("Plot Number: #{@plot.number}")
      expect(page).to have_content("Plot Number: #{@plot2.number}")
    end
  end
    
  it "when I visit the plots index page, under each plot number I see the names of all the plot's plants" do
    visit "/plots"

    within("#plot-#{@plot.id}") do
      expect(page).to have_content(@plant.name)
      expect(page).to_not have_content(@plant2.name)
    end
      
    within("#plot-#{@plot2.id}") do
      expect(page).to_not have_content(@plant.name)
      expect(page).to_not have_content(@plant2.name)
    end
  end
end