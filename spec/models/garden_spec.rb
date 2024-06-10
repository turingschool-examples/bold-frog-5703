require "rails_helper"

RSpec.describe Garden, type: :model do

  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plants).through(:plots) }
  end

  describe "instance methods" do
    it "can return unique list of plants with less than 100 days harvest days " do
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

      expect(@garden.plants_filtered.sort).to eq([@plant1, @plant3])
    end
  end
end