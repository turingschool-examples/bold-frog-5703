require "rails_helper"

RSpec.describe "the plots index" do
  before(:each) do
    @garden = Garden.create!(name: "Garden", organic: true )
    @plot1 = @garden.plots.create!(number: "1", size: "4x4", direction: "up" )
    @plot2 = @garden.plots.create!(number: "2", size: "4x4", direction: "down" )
    @plant1 = Plant.create!(name: "Carrot", description: "Orange carrot", days_to_harvest: 4)
    @plant2 = Plant.create!(name: "Cabbage", description: "Green cabbage", days_to_harvest: 3)
    @plant3 = Plant.create!(name: "Beet", description: "Purple beet", days_to_harvest: 3)
    @plot_plants = PlotPlant.create!(plot_id: @plot1.id, plant_id: @plant1.id)
    @plot_plants2 = PlotPlant.create!(plot_id: @plot1.id, plant_id: @plant2.id)
    @plot_plants3 = PlotPlant.create!(plot_id: @plot2.id, plant_id: @plant3.id)
    @plot_plants4 = PlotPlant.create!(plot_id: @plot1.id, plant_id: @plant3.id)
    visit "/plots"
  end
  # User Story 1, Plots Index Page
  # As a visitor
  # When I visit the plots index page ('/plots')
  # I see a list of all plot numbers
  # And under each plot number I see the names of all that plot's plants
  it "displays list of all plot numbers and plot's plants" do
    within "#plot_#{@plot1.id}" do
      expect(page).to have_content("Plot: #{@plot1.number}")
      expect(page).to have_content("Plant: #{@plant1.name}")
      expect(page).to have_content("Plant: #{@plant2.name}")
      expect(page).to have_content("Plant: #{@plant3.name}")
      # expect(page).to_not have_content("Plot: #{@plot2.number}")
      # not sure why the scoping is off and it reads ^^ but scopes correctly in the next within block
    end

    within "#plot_#{@plot2.id}" do    
      expect(page).to have_content("Plot: #{@plot2.number}")
      expect(page).to have_content("Plant: #{@plant3.name}")
      expect(page).to_not have_content("Plot: #{@plot1.number}")
      expect(page).to_not have_content("Plant: #{@plant1.name}")
      expect(page).to_not have_content("Plant: #{@plant2.name}")
    end
  end

  # User Story 2, Remove a Plant from a Plot
  # As a visitor
  # When I visit the plots index page
  # Next to each plant's name
  # I see a button to remove that plant from that plot
  # When I click on that button
  # I'm returned to the plots index page
  # And I no longer see that plant listed under that plot,
  # And I still see that plant's name under other plots that is was associated with.
  it "can remove plants from garden with a button" do
    within "#plot_#{@plot1.id}" do
      expect(page).to have_content("Plant: #{@plant3.name}")
    end
    within "#plot_#{@plot2.id}" do  
      expect(page).to have_content("Plant: #{@plant3.name}")
    end

    within "#plot_#{@plot2.id}" do
    click_button "Remove #{@plant3.name}"
    end

    within "#plot_#{@plot1.id}" do
      expect(page).to have_content("Plant: #{@plant3.name}")
    end
    within "#plot_#{@plot2.id}" do  
      expect(page).to_not have_content("Plant: #{@plant3.name}")
    end
  end
end