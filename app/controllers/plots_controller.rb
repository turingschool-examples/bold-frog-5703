class PlotsController < ApplicationController
  def index
    binding.pry
    @garden = Garden.find(params[:garden_id])
    @plots = @garden.plots
    binding.pry
  end
end