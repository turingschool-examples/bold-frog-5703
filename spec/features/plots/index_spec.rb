require "rails_helper"

RSpec.describe "Plots Index Page" do
    describe "As a Visitor" do
        it "When I visit the index I see a list of all the plot numbers and all the anmes of all the plants in that plot" do
            plot_1 = Plot.create!(number: 1, size: "Large", direction: "North")
            plot_2 = Plot.create!(number: 2, size: "Large", direction: "South")

            pepper = plot_1.plants.create!(name: "Pepper", description: "Needs sun")
            cucumber = plot_1.plants.create!(name: "Cucumber", description: "Needs water")
            tomato = plot_2.plants.create!(name: "Tomato", description: "Needs water")

            visit "/plots"

            within("#plot_1") do
                expect(page).to have_content(plot_1.number)
                expect(page).to have_content(pepper.name)
                expect(page).to have_content(cucumber.name)

                expect(page).to_not have_content(tomato.name)
            end
        end
    end
end