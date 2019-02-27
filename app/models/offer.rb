class Offer < ApplicationRecord
  belongs_to :product
  belongs_to :retailer
  has_many :prices, dependent: :destroy
end
