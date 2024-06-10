class PlotsController < ApplicationController
  def index
    # pry
    @plots = Plot.all
  end
end