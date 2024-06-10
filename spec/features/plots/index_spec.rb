require "rails_helper"

RSpec.describe Plot do
  before(:each) do
    @garden1 = Garden.create!(name: "Turing COmmunity Garden", organic: true)

    @plot1 = Plot.create!(number: 11, size: "Large", direction: "East", garden: @garden1)
    @plot2 = Plot.create!(number: 22, size: "Medium", direction: "North", garden: @garden1)
    @plot3 = Plot.create!(number: 33, size: "Small", direction: "West", garden: @garden1)

    @plant1 = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
    @plant2 = Plant.create!(name: "Avocado", description: "Makes great toast.", days_to_harvest: 34)
    @plant3 = Plant.create!(name: "Onion", description: "Goes great on a burger.", days_to_harvest: 55)
    @plant4 = Plant.create!(name: "Zucchini", description: "Tastes good when roasted", days_to_harvest: 48)
    @plant5 = Plant.create!(name: "Tomatoe", description: "So essential on a sandwich", days_to_harvest: 12)

    @plotplant1 = PlotPlant.create!(plot: @plot1, plant: @plant1)
    @plotplant2 = PlotPlant.create!(plot: @plot1, plant: @plant2)
    @plotplant3 = PlotPlant.create!(plot: @plot2, plant: @plant3)
    @plotplant4 = PlotPlant.create!(plot: @plot2, plant: @plant4)
    @plotplant5 = PlotPlant.create!(plot: @plot3, plant: @plant1)
    @plotplant6 = PlotPlant.create!(plot: @plot3, plant: @plant4)

    visit "/plots"
  end

  #   User Story 1, Plots Index Page

  # As a visitor
  # When I visit the plots index page ('/plots')
  # [x] I see a list of all plot numbers
  # [x] And under each plot number I see the names of all that plot's plants
  it "shows all the plots number and their associated plants" do
    within "#plot-#{@plot1.id}" do
    expect(page).to have_content("Plot Number: 11")
    expect(page).to have_content("Purple Beauty Sweet Bell Pepper")
    expect(page).to_not have_content("Tomatoe")
    end
  end

  #   User Story 2, Remove a Plant from a Plot

  # As a visitor
  # When I visit the plots index page
  # Next to each plant's name
  # []I see a button to remove that plant from that plot
  # []When I click on that button
  # []I'm returned to the plots index page
  # []And I no longer see that plant listed under that plot,
  # []And I still see that plant's name under other plots that is was associated with.

  # Note: you do not need to test for any sad paths or implement any flash messages. 

  it "removes a plant from a plot" do
    within "#plot-#{@plot1.id}" do
      within "#plot-plant#{@plotplant1.id}" do
        expect(page).to have_button("Delete Plant")
        click_button "Delete Plant"
      end
    end

    expect(current_path).to eq("/plots")

    within "#plot-#{@plot1.id}" do
      expect(page).to_not have_content("Purple Beauty Sweet Bell Pepper")
    end

    within "#plot-#{@plot3.id}" do
      expect(page).to have_content("Purple Beauty Sweet Bell Pepper")
    end
  end
end