require "rails_helper"

RSpec.describe Garden, type: :model do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plants).through(:plots)}
  end

  describe "instance variables" do
    describe "#list_of_plants" do
      it "should return a list of plants from the garden that are unique and take less than 100 days to harvest" do
        garden = Garden.create!(name: "Turing Community Garden", organic: true)
        plot_1 = Plot.create!(number: 25, size: "Large", direction: "East", garden_id: garden.id)
        plant_1 = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
        plant_2 = Plant.create!(name: "Plant 2", description: "Awesome Plant", days_to_harvest: 50)

        plot_2 = Plot.create!(number: 26, size: "Medium", direction: "West", garden_id: garden.id)
        plant_3 = Plant.create!(name: "BEANS", description: "Great beans happen here.", days_to_harvest: 60)
        plant_4 = Plant.create!(name: "Plant 4", description: "Plant 4 takes too long.", days_to_harvest: 101)

        PlotPlant.create!(plot_id: plot_1.id, plant_id: plant_1.id)
        PlotPlant.create!(plot_id: plot_1.id, plant_id: plant_2.id)
        PlotPlant.create!(plot_id: plot_2.id, plant_id: plant_3.id)
        PlotPlant.create!(plot_id: plot_2.id, plant_id: plant_2.id)
        PlotPlant.create!(plot_id: plot_2.id, plant_id: plant_4.id)

        expect(garden.list_of_plants).to eq([plant_1, plant_2, plant_3])
      end
    end
  end
end