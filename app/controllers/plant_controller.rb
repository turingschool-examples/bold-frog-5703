class PlantController < ApplicationController

  def destroy
    @plot = Plot.find(params[:plot_id])
    @plant = Plant.find(params[:id])
    @plant.destroy
    redirect_to plots_path(@plot)
  end
end