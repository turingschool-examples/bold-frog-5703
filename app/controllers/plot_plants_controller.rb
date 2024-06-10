class PlotPlantsController < ApplicationController
  def destroy
    # pry
    @plot_plant = PlotPlant.find(params[:id])
    @plot_plant.destroy
    redirect_to "/plots"
  end
end