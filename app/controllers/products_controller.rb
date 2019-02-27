class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
    @offers = @product.offers.joins(:retailer).order('retailers.rating ASC')
    @criteria = 'rating'
    if params[:sort_by_price]
      @offers = @product.offers.joins(:prices).order('prices.price ASC LIMIT 1')
    @criteria = 'price'
    end
    raise
    @alert = Alert.new
  end
end
