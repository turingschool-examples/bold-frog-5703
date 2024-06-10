require "rails_helper"

RSpec.describe "Plots Index Page" do
  before(:each) do
    @garden = Garden.create(name: "Eden", organic: true)

    @plot = Plot.create!(number: 25, size: "Large", direction: "East", garden_id: @garden.id)
    @plot2 = Plot.create!(number: 26, size: "Small", direction: "West", garden_id: @garden.id)

    @plant = Plant.create(name: "Apple", description: "Red Delicious", days_to_harvest: 90)
    @plant2 = Plant.create(name: "Strawberry", description: "Juicy and Sweet", days_to_harvest: 70)

    @plot_plant = PlotPlant.create!(plot: @plot, plant: @plant)
    @plot_plant2 = PlotPlant.create!(plot: @plot2, plant: @plant)
  end
  
  it "when I visit the plots index page, I see all of the plot numbers" do
    visit "/plots"
    # save_and_open_page
    within("#plots") do
      expect(page).to have_content("Plot Number: #{@plot.number}")
      expect(page).to have_content("Plot Number: #{@plot2.number}")
    end
  end
    
  xit "when I visit the plots index page, under each plot number I see the names of all the plot's plants" do
    visit "/plots"

    within("#plot-#{@plot.id}") do
      expect(page).to have_content(@plant.name)
      expect(page).to_not have_content(@plant2.name)
    end
      
    within("#plot-#{@plot2.id}") do
      expect(page).to have_content(@plant.name)
      expect(page).to_not have_content(@plant2.name)
    end
  end
  # User Story 2 - Remove a Plant from a Plot
  # As a visitor
  # When I visit the plots index page
  # Next to each plant's name
  # I see a button to remove that plant from that plot
  # When I click on that button
  # I'm returned to the plots index page
  # And I no longer see that plant listed under that plot,
  # And I still see that plant's name under other plots that is was associated with.
  
  it "there is a button on the plots index page to remove a plant from a plot" do
    visit "/plots"

    within("#plot-#{@plot.id}") do
      expect(page).to have_content(@plant.name)
    end

    within("#plot-#{@plot2.id}") do
      expect(page).to have_content(@plant.name)
      click_button("Remove")
    end
    
    expect(current_path).to eq("/plots")
    
    within("#plot-#{@plot.id}") do
      expect(page).to have_content(@plant.name)
    end

    within("#plot-#{@plot2.id}") do
      expect(page).to_not have_content(@plant.name)
    end
  end
end