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
  end
end
