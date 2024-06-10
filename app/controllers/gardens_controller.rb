class GardensController < ApplicationController
    def show
        @garden = Garden.find(params[:id])
        @plants = @garden.unique_plants_under_100_days
    end
end