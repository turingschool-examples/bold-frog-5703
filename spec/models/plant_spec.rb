require "rails_helper"

RSpec.describe Plant, type: :model do
    describe "relationships" do
        it { should have_many :plots_plants }
        it { should have_many(:plots).through(:plots_plants) }
    end
end