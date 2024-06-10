require "rails_helper"

RSpec.describe "Plots Index Page" do
    describe "As a Visitor" do
        it "When I visit the index I see a list of all the plot numbers and all the anmes of all the plants in that plot" do
            garden = Garden.create!(name: "Turing Community Garden", organic: true)
            plot_1 = garden.plots.create!(number: 1, size: "Large", direction: "North")
            plot_2 = garden.plots.create!(number: 2, size: "Large", direction: "South")

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
        # User Story 2, Remove a Plant from a Plot

        # As a visitor
        # When I visit the plots index page
        # Next to each plant's name
        # I see a button to remove that plant from that plot
        # When I click on that button
        # I'm returned to the plots index page
        # And I no longer see that plant listed under that plot,
        # And I still see that plant's name under other plots that is was associated with.

        # Note: you do not need to test for any sad paths or implement any flash messages. 
        it "I see a button to remove a plant from a plot" do
            garden = Garden.create!(name: "Turing Community Garden", organic: true)
            plot_1 = garden.plots.create!(number: 1, size: "Large", direction: "North")
            plot_2 = garden.plots.create!(number: 2, size: "Large", direction: "South")

            pepper = plot_1.plants.create!(name: "Pepper", description: "Needs sun")
            cucumber = plot_1.plants.create!(name: "Cucumber", description: "Needs water")

            tomato = plot_2.plants.create!(name: "Tomato", description: "Needs water")
            pepper_plot2 = plot_2.plants.create!(name: "Pepper", description: "Needs sun")

            visit "/plots"

            within("#plot_1") do
                expect(page).to have_content(plot_1.number)
                expect(page).to have_content(pepper.name)
                expect(page).to have_content(cucumber.name)

                expect(page).to_not have_content(tomato.name)

                click_button "Remove #{pepper.name}"
            end

            expect(current_path).to eq("/plots")

            within("#plot_1") do
                expect(page).to have_content(plot_1.number)
                expect(page).to_not have_content(pepper.name)
                expect(page).to have_content(cucumber.name)
            end

            within("#plot_2") do
                expect(page).to have_content(pepper_plot2.name)
            end
        end
    end
end