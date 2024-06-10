require "rails_helper"

RSpec.describe Plant, type: :model do
  describe 'relationships' do
    it { should have_many(:plot_plants) }
    it { should have_many(:plots).through(:plot_plants) }
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

  it "can count number of plots that plant is in" do
    expect(@plant7.plot_count).to eq(3)
  end
end