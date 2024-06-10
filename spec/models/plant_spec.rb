require "rails_helper"

RSpec.describe Plant, type: :model do
  describe "relationships" do
    it { should have_many(:plots).through(:plants_plots) }
  end
end
