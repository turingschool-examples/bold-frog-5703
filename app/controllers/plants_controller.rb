class PlantsController < ApplicationController

  def destroy
    @plot = Plot.find(params[:plot_id])
    @plant = Plant.find(params[:id])
    plot_plant = PlotPlant.find_by(plot_id: @plot.id, plant_id: @plant.id)
    plot_plant.destroy
    redirect_to plots_path
  end

end