class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
    @offers = @product.offers
    @alert = Alert.new
  end
end
