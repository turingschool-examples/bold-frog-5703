require 'rails_helper'

Rspec.describe 'Gardens show page' do
  before :each do
    @garden = Garden.create!(name: 'My Garden', organic: true)

    @plot1 = @garden.plots.create!(number: 1, size: 'Large', direction: 'North')
    @plot2 = @garden.plots.create!(number: 2, size: 'Small', direction: 'East')

    @plant1 = Plant.create!(name: 'Sunflower', description: 'seeds', days_to_harvest: 100)
    @plant2 = Plant.create!(name: 'Rose', description: 'are red', days_to_harvest: 200)
    @plant3 = Plant.create!(name: 'Violet', description: 'are blue', days_to_harvest: 90)

    PlantPlot.create!(plant: @plant1, plot: @plot1)
    PlantPlot.create!(plant: @plant2, plot: @plot1)
    PlantPlot.create!(plant: @plant3, plot: @plot2)

  end

  describe 'As a user' do
    it 'I see a list of plants that are included in that garden plots' do
      visit garden_path(@garden)

      expect(page).to have_content(plant1.name)
      expect(page).to have_content(plant2.name)
      expect(page).to have_content(plant3.name)
    end
  end
end