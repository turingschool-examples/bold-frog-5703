class PlotPlantsController < ApplicationController

  def destroy
    plot_id = params[:plot_id]
    plant_id = params[:plant_id]
    @plot_plant = PlotPlant.find_by(plot_id: plot_id, plant_id: plant_id )
    @plot_plant.destroy
    redirect_to plots_path
  end
end