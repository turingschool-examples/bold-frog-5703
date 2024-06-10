class GardensController < ApplicationController
  def show
    @garden = Garden.find(params[:id])
    @plants = @garden.list_of_plants
  end
end