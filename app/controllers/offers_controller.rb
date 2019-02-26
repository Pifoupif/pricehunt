class OffersController < ApplicationController
  def index
    @offers = Offer.all
    @product = Product.find(params[:id])
    @product_offer = @offers.where(@product.id = @offers.product_id)
  end
end
