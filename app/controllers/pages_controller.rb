# require "google/cloud/vision"
class PagesController < ApplicationController
  def home
    @home = ""
    if params[:query].present?
      sql_query = "products.denich_id @@ :query"
      @products = Product.where(sql_query, query: "%#{params[:query]}%")
    else
      @products = Product.all
    end

    if params[:photo]

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
      @items = data['message']['product']['items']
      # redirect_to product_path(@product, query: item['id'])
      # redirect_to search_results_products_path(items: items)
    end

    respond_to do |format|
      format.html
      format.js
    end
  end
end

