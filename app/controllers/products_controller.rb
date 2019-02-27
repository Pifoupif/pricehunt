class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
    @offers = @product.offers.joins(:retailer).order('retailers.rating ASC')
    if params[:sort_by_price]
      @offers = @product.offers.joins(:prices).order('prices.price ASC LIMIT 1')
    end
    @alert = Alert.new
  end
end
