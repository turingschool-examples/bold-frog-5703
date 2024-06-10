require "rails_helper"

RSpec.describe Garden, type: :model do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plants).through(:plots) }
  end

  before(:each) do
    @garden1 = Garden.create(name: "Huntington Garden", organic: true)
    @garden2 = Garden.create(name: "Tivoli Garden", organic: false)

    @plot1 = Plot.create(number: 10, size: "Small", direction: "North", garden_id: @garden1.id)
    @plot2 = Plot.create(number: 20, size: "Medium", direction: "South", garden_id: @garden1.id)
    @plot3 = Plot.create(number: 30, size: "Large", direction: "East", garden_id: @garden1.id)
    @plot4 = Plot.create(number: 40, size: "Small", direction: "West", garden_id: @garden2.id)
    @plot5 = Plot.create(number: 50, size: "Medium", direction: "North", garden_id: @garden2.id)
    @plot6 = Plot.create(number: 60, size: "Medium", direction: "North", garden_id: @garden2.id)

    @plant1 = Plant.create(name: "Daisy", description: "beautiful flower", days_to_harvest: 70)
    @plant2 = Plant.create(name: "Lily", description: "alluring flower", days_to_harvest: 75)
    @plant3 = Plant.create(name: "Dahlia", description: "appealing flower", days_to_harvest: 80)
    @plant4 = Plant.create(name: "Rose", description: "attractive flower", days_to_harvest: 85)
    @plant5 = Plant.create(name: "Violet", description: "exquisite flower", days_to_harvest: 90)
    @plant6 = Plant.create(name: "Iris", description: "gorgeous flower", days_to_harvest: 90)
    @plant7 = Plant.create(name: "Azalea", description: "lovely flower", days_to_harvest: 95)
    @plant8 = Plant.create(name: "Peony", description: "stunning flower", days_to_harvest: 100)

    #@garden2 plot_plants
    PlotPlant.create(plot_id: @plot4.id, plant_id: @plant1.id)
    PlotPlant.create(plot_id: @plot4.id, plant_id: @plant7.id)
    PlotPlant.create(plot_id: @plot4.id, plant_id: @plant5.id)
    PlotPlant.create(plot_id: @plot4.id, plant_id: @plant6.id)
    PlotPlant.create(plot_id: @plot4.id, plant_id: @plant8.id)
    PlotPlant.create(plot_id: @plot5.id, plant_id: @plant1.id)
    PlotPlant.create(plot_id: @plot5.id, plant_id: @plant7.id)
    PlotPlant.create(plot_id: @plot6.id, plant_id: @plant7.id)
  end

  describe "plants_list" do
    it "returns a list of unique plants, all of which take less than 100 days to harvest" do
      expect(@garden2.plants_list).to eq([@plant1, @plant5, @plant6, @plant7])
    end
  end

  describe "sorted_plants" do
    it "returns a list sorted by how many time plants appear in garden's plots" do
      expect(@garden2.sorted_plants).to eq([@plant7, @plant1, @plant5, @plant6])
    end
  end
end