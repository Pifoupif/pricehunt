class ProductsController < ApplicationController
  def show
    @alert = Alert.new
    if params[:query]
      @product = Product.find_by(denich_id: params[:query])
      if @product
        @product
      else
        @product = PricehuntJob.perform_now(params[:query])
      end
    else
      @product = Product.find(params[:id])
    end
    @offers = @product.offers.joins(:prices).order('prices.price ASC')
    filter
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

private

  def filter
    @filter = false
    if params[:sort_by_price]
      @filter = true
      @offers = @product.offers.joins(:prices).order('prices.price ASC')
    end
  end
  # def search_show
  #   @product = Product.where(name: params[:query]).first
  #   redirect_to product_path(@product)
  # end

end

  # def show
  #   if params[:query]
  #     @product = Product.where("denich_id ILIKE ?", "%#{params[:query]}%").first
  #     redirect_to product_path(@product)
  #   else
  #     @product = Product.find(params[:id])
  #     @offers = @product.offers.joins(:retailer).order('retailers.rating DESC')
  #     @filter = false
  #     if params[:sort_by_price]
  #       @filter = true
  #       @offers = @product.offers.joins(:prices).order('prices.price ASC')
  #     end
  #     @alert = Alert.new
  #   end
