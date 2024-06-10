class PlotsPlantsController < ApplicationController
    def destroy
        plot_plant = PlotsPlant.find(params[:id])
        plot_plant.destroy

        redirect_to '/plots'
    end
end