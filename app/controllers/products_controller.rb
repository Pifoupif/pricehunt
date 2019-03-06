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
    @denich_id = params[:query] || params[:id]
    @product = Product.includes(offers: :prices).includes(offers: :retailer).find_by(denich_id: @denich_id)
    unless @product.present? && @product.updated_at.to_date == Time.zone.today
      @product = ScrapeProductService.new(@denich_id).call
    end
    @offers = @product.offers.includes(:prices, :retailer)
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
    if params[:sort_by_rating]
      @filter = false
      @offers = @product.offers.joins(:retailer).order('retailers.rating DESC')
    else
      @filter = true
      @offers = @offers.sort do |of, fer|
        of.prices.last.price <=> fer.prices.last.price
      end
    end
  end

end

