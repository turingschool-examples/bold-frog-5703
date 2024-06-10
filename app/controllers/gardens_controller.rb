class GardensController < ApplicationController
  def show
    @garden = Garden.find(params[:id])
    @plots = @garden.plots
    @plants = @garden.plants
  end
end