require "rails_helper"

RSpec.describe Garden, type: :model do
  describe 'relationships' do
    it { should have_many(:plots) }
  end

  describe '#harvests_in_less_than_100_days' do
    before do
      @garden1 = Garden.create!(name: "Movsar's Garden")
      @garden2 = Garden.create!(name: "Evleov's Garden")

      @plot1 = Plot.create!(number: 1, size: "Large", direction: "East", garden_id: @garden1.id)
      @plot2 = Plot.create!(number: 2, size: "Large", direction: "East", garden_id: @garden1.id)
      @plot3 = Plot.create!(number: 3, size: "Medium", direction: "North", garden_id: @garden1.id)
      @plot4 = Plot.create!(number: 4, size: "Small", direction: "West", garden_id: @garden2.id)
      @plot5 = Plot.create!(number: 5, size: "Small", direction: "West", garden_id: @garden2.id)

      @plant1 = Plant.create!(name: "Purple Beuty Sweet Bell Pepper", description: "Likes well draining soil", days_to_harvest: 100)
      @plant2 = Plant.create!(name: "Red Hot Bell Pepper", description: "Likes dry soil", days_to_harvest: 99)
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

    it 'returns plants that harvest in less than 100 days' do
      plants = @garden1.harvests_in_less_than_100_days
      expect(plants).to include(@plant2, @plant3)
      expect(plants).not_to include(@plant1, @plant4)
      expect(plants.count).to eq(2)
    end
  end
end