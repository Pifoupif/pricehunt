class ProductsController < ApplicationController
  def search
    @product = Product.first # for the searchbar

    # Google Vision
    image_annotator = Google::Cloud::Vision::ImageAnnotator.new
    # file_name = File.new(open('app/assets/images/Stan-smith.jpg'))
    file_name = params[:photo].path
    response = image_annotator.web_detection image: file_name

    @descriptions = []
    response.responses.each do |res|
      res.web_detection.web_entities.each do |entity|
        @descriptions << entity.description
      end
    end

    # Denicheur
    keyword = @descriptions.first

    denicheur_url = "https://search.ledenicheur.fr/classic?class=Search_Supersearch&method=search&market=fr&skip_login=1&modes=product,raw_sorted,raw&limit=12&q=#{keyword}"
    response = open(denicheur_url).read
    data = JSON.parse(response)

    item = data['message']['product']['items'].first
    redirect_to product_path(@product, query: item['id'])
  end

  def show
    @alert = Alert.new
    if params[:query]
      @product = Product.find_by(denich_id: params[:query])
      @offers = @product.offers.joins(:prices).order('prices.price ASC')
    else
      @product = Product.find(params[:id])
      @offers = @product.offers.joins(:retailer).order('retailers.rating DESC')
    end
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
