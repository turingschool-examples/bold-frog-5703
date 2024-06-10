require "rails_helper"

RSpec.describe Garden, type: :model do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plot_plants).through(:plots) }
    it { should have_many(:plants).through(:plot_plants) }
  end

  it 'can return a list of unique plants that take less than 100 days to harvest' do
    @garden1 = Garden.create!(name: "Turing Community Garden", organic: true)
    @garden2 = Garden.create!(name: "Cali Garden", organic: true)

    @plot1 = Plot.create!(number: 11, size: "Large", direction: "East", garden: @garden1)
    @plot2 = Plot.create!(number: 22, size: "Medium", direction: "North", garden: @garden1)
    @plot3 = Plot.create!(number: 33, size: "Small", direction: "West", garden: @garden2)

    @plant1 = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
    @plant2 = Plant.create!(name: "Avocado", description: "Makes great toast.", days_to_harvest: 34)
    @plant3 = Plant.create!(name: "Onion", description: "Goes great on a burger.", days_to_harvest: 55)
    @plant4 = Plant.create!(name: "Zucchini", description: "Tastes good when roasted", days_to_harvest: 19)
    @plant5 = Plant.create!(name: "Tomatoe", description: "So essential on a sandwich", days_to_harvest: 120)

    @plotplant1 = PlotPlant.create!(plot: @plot1, plant: @plant1)
    @plotplant2 = PlotPlant.create!(plot: @plot1, plant: @plant2)
    @plotplant3 = PlotPlant.create!(plot: @plot2, plant: @plant3)
    @plotplant4 = PlotPlant.create!(plot: @plot2, plant: @plant1)
    @plotplant5 = PlotPlant.create!(plot: @plot3, plant: @plant1)
    @plotplant6 = PlotPlant.create!(plot: @plot3, plant: @plant4)

    expect(@garden1.quick_plants).to match_array([@plant1.name, @plant2.name, @plant3.name])
    expect(@garden1.quick_plants).to_not match_array([@plant4.name, @plant5.name])
  end
end