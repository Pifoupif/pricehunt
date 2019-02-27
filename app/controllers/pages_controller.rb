class PagesController < ApplicationController
  def home
    @home = ""

    if params[:query].present?
      sql_query = "products.name @@ :query"
      @products = Product.where(sql_query, query: "%#{params[:query]}%")
    else
      @products = Product.all
    end
  end
end
