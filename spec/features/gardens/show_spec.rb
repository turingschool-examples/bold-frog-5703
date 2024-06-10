require "rails_helper"

RSpec.describe "gardens show page" do
  describe "gardens show page" do
    before :each do
      @garden1 = Garden.create!(name: "Movsar's Garden")
      @garden2 = Garden.create!(name: "Evleov's Garden")

      @plot1 = Plot.create!(number: 1, size: "Large", direction: "East", garden_id: @garden1.id)
      @plot2 = Plot.create!(number: 2, size: "Large", direction: "East", garden_id: @garden1.id)
      @plot3 = Plot.create!(number: 3, size: "Medium", direction: "North", garden_id: @garden1.id)
      @plot4 = Plot.create!(number: 4, size: "Small", direction: "West", garden_id: @garden2.id)
      @plot5 = Plot.create!(number: 5, size: "Small", direction: "West", garden_id: @garden2.id)

      @plant1 = Plant.create!(name: "Purple Beuty Sweet Bell Pepper", description: "Likes well draining soil", days_to_harvest: 90)
      @plant2 = Plant.create!(name: "Red Hot Bell Pepper", description: "Likes dry soil", days_to_harvest: 60)
      @plant3 = Plant.create!(name: "Green Sour Bell Pepper", description: "Likes damp thick soil", days_to_harvest: 50)
      @plant4 = Plant.create!(name: "Blue Dry Bell Pepper", description: "Enjoys arid climate", days_to_harvest: 40)
    
      @pp_1 = PlantPlot.create!(plant_id: @plant1.id, plot_id: @plot1.id)
      @pp_2 = PlantPlot.create!(plant_id: @plant2.id, plot_id: @plot1.id)
      @pp_3 = PlantPlot.create!(plant_id: @plant1.id, plot_id: @plot2.id)
      @pp_4 = PlantPlot.create!(plant_id: @plant3.id, plot_id: @plot2.id)
      @pp_5 = PlantPlot.create!(plant_id: @plant3.id, plot_id: @plot3.id)
      @pp_6 = PlantPlot.create!(plant_id: @plant2.id, plot_id: @plot3.id)
      @pp_7 = PlantPlot.create!(plant_id: @plant3.id, plot_id: @plot4.id)
      @pp_8 = PlantPlot.create!(plant_id: @plant4.id, plot_id: @plot4.id)
    
    end

    it "lists of plants included in that gardens plots" do
      visit garden_path(@garden1)

      within ("#garden_#{@garden1.id}") do
        expect(page).to have_content(@plant1.name)
        expect(page).to have_content(@plant2.name)
        expect(page).to have_content(@plant3.name)
        
        expect(page).to_not have_content(@plant4.name)
      end

    end
  end
end