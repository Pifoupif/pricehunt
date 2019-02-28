class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
    @offers = @product.offers.joins(:retailer).order('retailers.rating DESC')
    @filter = false
    if params[:sort_by_price]
      @filter = true
      @offers = @product.offers.joins(:prices).order('prices.price ASC')
    end
    @alert = Alert.new
  end
end
