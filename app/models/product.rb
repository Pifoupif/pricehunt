class Product < ApplicationRecord
  belongs_to :category
  has_many :offers, dependent: :destroy
  has_many :alerts
end
