class PlotsPlant < ApplicationRecord
    belongs_to :plot
    belongs_to :plant
    # why are these names messing with my head so much plants plot or plots plant IM GOING CRAZY
end