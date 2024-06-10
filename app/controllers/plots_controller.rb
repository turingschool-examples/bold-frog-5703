class PlotsController < ApplicationController
  def index
    @plots = Plot.includes(:plot_plants, :plants).all
  end
end