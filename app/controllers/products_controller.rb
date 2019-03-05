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
    items = data['message']['product']['items']
    # redirect_to product_path(@product, query: item['id'])
    redirect_to search_results_products_path(items: items)
  end

  def search_results
    @results = params[:items]
  end

  # Below is not the proper way to implement the show but it works with filters
   def show
    @alert = Alert.new
    @denich_id = params[:query]
    if Product.find_by(denich_id: @denich_id).nil? == false &&
      Product.find_by(denich_id: @denich_id).updated_at.to_date == Time.zone.today
      @product = Product.find_by(denich_id: @denich_id)
    else
      @product = ScrapeProductService.new(@denich_id).call
    end

    @offers = @product.offers
    filter
  end

  # Below is the proper way to implement the show but doesn't work with filters
  # def show
  #   @alert = Alert.new
  #   @denich_id = params[:query]
  #   @product = ScrapeProductService.new(@denich_id).call
  #   @offers_price = @product.offers
  #   @offers_rating = @product.offers.joins(:retailer).order('retailers.rating DESC')
  #   filter
  # end

private

  def filter
    @filter = false
    if params[:sort_by_price]
      @filter = true
      @offers = @product.offers
    end
    if params[:sort_by_rating]
      @filter = true
      @offers = @product.offers.joins(:retailer).order('retailers.rating DESC')
    end
  end

end

