class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
    @offers = @product.offers
  end
end
