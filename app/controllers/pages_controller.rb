class PagesController < ApplicationController
  def home
    @home = ""
    @product = Product.where("name ILIKE ?", "%#{params[:query]}%").first
    #@product = Product.where(denich_id: params[:query])
    #@product = Product.find("denich_id ILIKE ?", "%#{params[:query]}%")
    if params[:query].present?
      sql_query = "products.denich_id @@ :query"
      @products = Product.where(sql_query, query: "%#{params[:query]}%")
    else
      @products = Product.all
    end
  end
end
