class PlantPlotsController < ApplicationController
  def destroy
    @plot = Plot.find(params[:plot_id])
    @plant = @plot.plants.find(params[:id])
    @plot.plants.delete(@plant)
    redirect_to plots_path
  end
end