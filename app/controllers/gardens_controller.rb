class GardensController < ApplicationController

  def show
    @garden = Garden.find(params[:id])
    @garden_quick_plants = @garden.quick_plants
  end
end