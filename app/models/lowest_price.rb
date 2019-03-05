class LowestPrice < ApplicationRecord
  belongs_to :price
  belongs_to :alert
end
