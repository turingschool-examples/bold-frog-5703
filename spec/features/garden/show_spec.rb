require "rails_helper"

RSpec.describe "Garden Show Page" do
    describe "As a Visitor" do
        # User Story 3, Garden's Plants

        # As a visitor
        # When I visit a garden's show page ('/gardens/:id')
        # Then I see a list of plants that are included in that garden's plots
        # And I see that this list is unique (no duplicate plants)
        # And I see that this list only includes plants that take less than 100 days to harvest
        it "i see a list of plats in that garden UNIQUE LIST and only plats that take LESS then 100 days to harvest" do
            garden = Garden.create!(name: "Garrett's Secret Remote Off Grid Garden", organic: true)
            plot_1 = garden.plots.create!(number: 1, size: "Large", direction: "North")
            plot_2 = garden.plots.create!(number: 2, size: "Large", direction: "South")

            pepper = plot_1.plants.create!(name: "Pepper", description: "Needs sun", days_to_harvest: 32)
            cucumber = plot_1.plants.create!(name: "Cucumber", description: "Needs water", days_to_harvest: 95)
            plant = plot_1.plants.create!(name: "Mysterious Plant", description: "Needs water", days_to_harvest: 365)
            # what else do people garden

            tomato = plot_2.plants.create!(name: "Tomato", description: "Needs water", days_to_harvest: 105)
            plot_2.plants.create!(name: "Pepper", description: "Needs sun", days_to_harvest: 32)

            visit "/gardens/#{garden.id}"

            within("#garden_plants") do
                expect(page).to have_content(pepper.name, count: 1)
                expect(page).to have_content(cucumber.name)

                # Take Long TIME 
                expect(page).to_not have_content(plant.name)
                expect(page).to_not have_content(tomato.name)
            end
        end
    end
end