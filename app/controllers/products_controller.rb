class ProductsController < ApplicationController
  def show
    @alert = Alert.new
    if params[:query]
      @product = Product.find_by(denich_id: params[:query])
      @offers = @product.offers.joins(:prices).order('prices.price ASC')
    else
      @product = Product.find(params[:id])
      @offers = @product.offers.joins(:retailer).order('retailers.rating DESC')
    end

    # if params[:query]
    #   #@product = Product.find(denich_id: params[:query])
    #   @product = Product.where("denich_id ILIKE ?", params[:query])
    #   #@product = Product.where("denich_id ILIKE ?", "%#{params[:query]}%").first
    #   redirect_to product_path(@product)
    # else
    #   @filter = false
    #   if params[:sort_by_price]
    #     @filter = true
    #   end
    # end
  end

  # def search_show
  #   @product = Product.where(name: params[:query]).first
  #   redirect_to product_path(@product)
  # end

end

