class PlotsController < ApplicationController
  
  def index
    @plots = Plot.all
    # binding.pry
  end
  
end