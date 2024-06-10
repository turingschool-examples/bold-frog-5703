class PlotPlantsController < ApplicationController
  
  def destroy
    @plot = Plot.find(params[:plot_id])
    @plot.plants.find(params[:id]).destroy
    redirect_to "/plots"
  end

end