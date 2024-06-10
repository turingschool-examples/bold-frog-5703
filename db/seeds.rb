# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

@garden1 = Garden.create!(name: "Turing COmmunity Garden", organic: true)
@garden2 = Garden.create!(name: "Cali Garden", organic: true)

@plot1 = Plot.create!(number: 11, size: "Large", direction: "East", garden: @garden1)
@plot2 = Plot.create!(number: 22, size: "Medium", direction: "North", garden: @garden1)
@plot3 = Plot.create!(number: 33, size: "Small", direction: "West", garden: @garden2)

@plant1 = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
@plant2 = Plant.create!(name: "Avocado", description: "Makes great toast.", days_to_harvest: 34)
@plant3 = Plant.create!(name: "Onion", description: "Goes great on a burger.", days_to_harvest: 55)
@plant4 = Plant.create!(name: "Zucchini", description: "Tastes good when roasted", days_to_harvest: 110)
@plant5 = Plant.create!(name: "Tomatoe", description: "So essential on a sandwich", days_to_harvest: 12)

@plotplant1 = PlotPlant.create!(plot: @plot1, plant: @plant1)
@plotplant2 = PlotPlant.create!(plot: @plot1, plant: @plant2)
@plotplant3 = PlotPlant.create!(plot: @plot2, plant: @plant3)
@plotplant4 = PlotPlant.create!(plot: @plot2, plant: @plant4)
@plotplant5 = PlotPlant.create!(plot: @plot3, plant: @plant1)
@plotplant6 = PlotPlant.create!(plot: @plot3, plant: @plant4)