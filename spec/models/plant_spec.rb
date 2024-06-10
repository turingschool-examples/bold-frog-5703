require "rails_helper"

RSpec.describe Plant, type: :model do
  describe 'relationships' do
    it {should have_many :plot_plants}
    it {should have_many(:plots).through(:plot_plants)}
  end

  describe "instance method" do
    it "can return a plot plant by plot id" do
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

      expect(@plant1.plot_plant_by_plot(@plot1.id)).to eq(@plot_plants)
    end
  end
end