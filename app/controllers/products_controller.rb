class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
    @alert = Alert.new
  end
end
