class Offer < ApplicationRecord
  belongs_to :product
  belongs_to :retailer
  has_many :prices, dependent: :destroy

  validates :product, uniqueness: { scope: :retailer, message: "product already associated to retailer" }
end
