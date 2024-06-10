require 'rails_helper'

RSpec.describe 'Plots index page' do
  before :each do
    @garden = Garden.create!(name: 'My Garden', organic: true)

    @plot1 = @garden.plots.create!(number: 1, size: 'Large', direction: 'North')
    @plot2 = @garden.plots.create!(number: 2, size: 'Small', direction: 'South')

    @plant1 = Plant.create!(name: 'Sunflower', description: 'seeds', days_to_harvest: 100)
    @plant2 = Plant.create!(name: 'Rose', description: 'are red', days_to_harvest: 200)
    @plant3 = Plant.create!(name: 'Violet', description: 'are blue', days_to_harvest: 90)
  end

  describe 'As a User' do
    it 'I see a list of all plot numbers' do
      visit plots_path

      expect(page).to have_content("Plot: #{@plot1.number}")
      expect(page).to have_content("Plot: #{@plot2.number}")
      expect(page).to_not have_content(@plant1.name)
      expect(page).to_not have_content(@plant2.name)
    end

    it 'I see a list of plants associated with each plot' do
      visit plots_path

      expect(page).to_not have_content(@plant1.name)

      PlantPlot.create!(plant: @plant1, plot: @plot1)
      PlantPlot.create!(plant: @plant2, plot: @plot1)

      visit plots_path
 
      expect(page).to have_content(@plant1.name)
      expect(page).to have_content(@plant2.name)
      expect(page).to_not have_content(@plant3.name)
    end

    it 'I see a link to remove a plant from a plot' do
      PlantPlot.create!(plant: @plant1, plot: @plot1)
      PlantPlot.create!(plant: @plant1, plot: @plot2)

      visit plots_path

      within("#plot-#{@plot1.id}") do  
        click_button('Remove Plant')
 
        expect(page).to_not have_content(@plant1.name)
      end
      within("#plot-#{@plot2.id}") do
        expect(page).to have_content(@plant1.name)
      end
    end
  end
end