class GardensController < ApplicationController
  def show
    @garden = Garden.find(params[:id])
    @plants = @garden.plants_filtered
  end
end