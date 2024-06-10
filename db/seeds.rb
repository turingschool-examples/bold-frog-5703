# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

garden1 = Garden.create!(name: "Movsar's Garden", organic: true)
garden2 = Garden.create!(name: "Evleov's Garden", organic: false)

plot1 = Plot.create!(number: 1, size: "Large", direction: "East", garden: garden1)
plot2 = Plot.create!(number: 2, size: "Large", direction: "East", garden: garden1)
plot3 = Plot.create!(number: 3, size: "Medium", direction: "North", garden: garden1)
plot4 = Plot.create!(number: 4, size: "Small", direction: "West", garden: garden2)
plot5 = Plot.create!(number: 5, size: "Small", direction: "West", garden: garden2)

plant1 = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Likes well draining soil", days_to_harvest: 90)
plant2 = Plant.create!(name: "Red Hot Bell Pepper", description: "Likes dry soil", days_to_harvest: 60)
plant3 = Plant.create!(name: "Green Sour Bell Pepper", description: "Likes damp thick soil", days_to_harvest: 50)
plant4 = Plant.create!(name: "Blue Dry Bell Pepper", description: "Enjoys arid climate", days_to_harvest: 40)

PlantPlot.create!(plant: plant1, plot: plot1)
PlantPlot.create!(plant: plant2, plot: plot1)
PlantPlot.create!(plant: plant1, plot: plot2)
PlantPlot.create!(plant: plant3, plot: plot2)
PlantPlot.create!(plant: plant3, plot: plot3)
PlantPlot.create!(plant: plant2, plot: plot3)
PlantPlot.create!(plant: plant3, plot: plot4)
PlantPlot.create!(plant: plant4, plot: plot4)
