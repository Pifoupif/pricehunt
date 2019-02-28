class ProductsController < ApplicationController
  def show
    if params[:query]
      @product = Product.where("denich_id ILIKE ?", "%#{params[:query]}%").first
      redirect_to product_path(@product)
    else
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

  def search_show
    @product = Product.where(name: params[:query]).first
    redirect_to product_path(@product)
  end

end

