require "google/cloud/vision"

class PagesController < ApplicationController
  def home
    @home = ""
    @product = Product.first
    #@product = Product.find("denich_id ILIKE ?", "%#{params[:query]}%")
    if params[:query].present?
      sql_query = "products.denich_id @@ :query"
      @products = Product.where(sql_query, query: "%#{params[:query]}%")
    else
      @products = Product.all
    end

    image_annotator = Google::Cloud::Vision::ImageAnnotator.new
    file_name = File.new(open('app/assets/images/Stan-smith.jpg'))
    response = image_annotator.web_detection image: file_name

    @descriptions = []
    response.responses.each do |res|
      res.web_detection.web_entities.each do |entity|
        @descriptions << entity.description
      end
    end
  end
end
