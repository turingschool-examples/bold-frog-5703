require "rails_helper"

RSpec.describe Garden, type: :model do
  describe 'relationships' do
    it { should have_many(:plots) }
  end

  describe 'instance methods' do
    it "returns list of plants ready to harvest in less then 100 days no duplicates" do
      garden = Garden.create!(name: "Garrett's Secret Remote Off Grid Garden", organic: true)
            plot_1 = garden.plots.create!(number: 1, size: "Large", direction: "North")
            plot_2 = garden.plots.create!(number: 2, size: "Large", direction: "South")

            pepper = plot_1.plants.create!(name: "Pepper", description: "Needs sun", days_to_harvest: 32)
            cucumber = plot_1.plants.create!(name: "Cucumber", description: "Needs water", days_to_harvest: 95)
            plant = plot_1.plants.create!(name: "Mysterious Plant", description: "Needs water", days_to_harvest: 365)

            tomato = plot_2.plants.create!(name: "Tomato", description: "Needs water", days_to_harvest: 105)
            plot_2.plants.create!(name: "Pepper", description: "Needs sun", days_to_harvest: 32)

            expect(garden.plants_under_100_days).to match_array([pepper.name, cucumber.name])
            expect(garden.plants_under_100_days).to_not include(plant.name)
            expect(garden.plants_under_100_days).to_not include(tomato.name)
    end
  end
end