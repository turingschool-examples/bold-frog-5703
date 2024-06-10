require "rails_helper"

RSpec.describe "the plots index" do
  before(:each) do
    @garden1 = Garden.create(name: "Huntington Garden", organic: true)
    @garden2 = Garden.create(name: "Tivoli Garden", organic: false)

    @plot1 = Plot.create(number: 10, size: "Small", direction: "North", garden_id: @garden1.id)
    @plot2 = Plot.create(number: 20, size: "Medium", direction: "South", garden_id: @garden1.id)
    @plot3 = Plot.create(number: 30, size: "Large", direction: "East", garden_id: @garden1.id)
    @plot4 = Plot.create(number: 40, size: "Small", direction: "West", garden_id: @garden2.id)
    @plot5 = Plot.create(number: 50, size: "Medium", direction: "North", garden_id: @garden2.id)

    @plant1 = Plant.create(name: "Daisy", description: "beautiful flower", days_to_harvest: 70)
    @plant2 = Plant.create(name: "Lily", description: "alluring flower", days_to_harvest: 75)
    @plant3 = Plant.create(name: "Dahlia", description: "appealing flower", days_to_harvest: 80)
    @plant4 = Plant.create(name: "Rose", description: "attractive flower", days_to_harvest: 85)
    @plant5 = Plant.create(name: "Violet", description: "exquisite flower", days_to_harvest: 90)
    @plant6 = Plant.create(name: "Iris", description: "gorgeous flower", days_to_harvest: 90)
    @plant7 = Plant.create(name: "Azalea", description: "lovely flower", days_to_harvest: 95)
    @plant8 = Plant.create(name: "Peony", description: "stunning flower", days_to_harvest: 100)

    PlotPlant.create(plot_id: @plot1.id, plant_id: @plant4.id)
    PlotPlant.create(plot_id: @plot1.id, plant_id: @plant6.id)
    PlotPlant.create(plot_id: @plot2.id, plant_id: @plant7.id)
    PlotPlant.create(plot_id: @plot3.id, plant_id: @plant3.id)
    PlotPlant.create(plot_id: @plot4.id, plant_id: @plant2.id)
    PlotPlant.create(plot_id: @plot4.id, plant_id: @plant3.id)
    PlotPlant.create(plot_id: @plot4.id, plant_id: @plant5.id)
    PlotPlant.create(plot_id: @plot4.id, plant_id: @plant6.id)
    PlotPlant.create(plot_id: @plot4.id, plant_id: @plant8.id)
    PlotPlant.create(plot_id: @plot5.id, plant_id: @plant1.id)
    PlotPlant.create(plot_id: @plot5.id, plant_id: @plant7.id)
  end

  it "shows a list of all plots with their number" do
    visit plots_path

    plots = Plot.all
    plots.each do |plot|
      within "#plot-#{plot.id}" do
        expect(page).to have_content("Plot #{plot.number}")
      end
    end
  end

  it "shows all plants within each plot" do
    visit plots_path

    within "#plot-#{@plot1.id}" do
      expect(page).to have_content("Rose")
      expect(page).to have_content("Iris")
    end

    within "#plot-#{@plot2.id}" do
      expect(page).to have_content("Azalea")
    end

    within "#plot-#{@plot3.id}" do
      expect(page).to have_content("Dahlia")
    end

    within "#plot-#{@plot4.id}" do
      expect(page).to have_content("Lily")
      expect(page).to have_content("Dahlia")
      expect(page).to have_content("Violet")
      expect(page).to have_content("Iris")
      expect(page).to have_content("Peony")
    end

    within "#plot-#{@plot5.id}" do
      expect(page).to have_content("Daisy")
      expect(page).to have_content("Azalea")
    end
  end

  it "should have buttons to delete each plant" do
    visit plots_path

    within "#plot-#{@plot1.id}" do
      expect(page).to have_button("Delete Rose")
      expect(page).to have_button("Delete Iris")
    end

    within "#plot-#{@plot2.id}" do
      expect(page).to have_button("Delete Azalea")
    end
  end

  it "should be able to delete a plant from a plot without it affecting other plots" do
    visit plots_path

    within "#plot-#{@plot4.id}" do
      click_button "Delete Iris"
    end

    expect(current_path).to eq(plots_path)

    within "#plot-#{@plot4.id}" do
      expect(page).to_not have_content("Iris")
    end

    within "#plot-#{@plot1.id}" do
      expect(page).to have_content("Iris")
    end
  end

end