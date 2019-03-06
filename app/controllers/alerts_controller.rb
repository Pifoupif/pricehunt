class AlertsController < ApplicationController
  def create
    @alert = Alert.new(alert_params)
    @alert.user = current_user
    @alert.product_id = params[:product_id]
    @alert.user = current_user
    if @alert.save
      respond_to do |format|
        format.html { redirect_to alerts_path }
        format.js
      end
      sleep(1.5)
    else
      @product = Product.find(params[:product_id])
      @offers = @product.offers
      respond_to do |format|
        format.html { render 'products/show' }
        format.js
      end
    end
  end

  def edit
  end

  def show
    @product = Product.where("name ILIKE ?", "%#{params[:query]}%").first
    @alert = Alert.find(params[:id])
  end

  def index
    @product = Product.where("name ILIKE ?", "%#{params[:query]}%").first
    @user_alerts = Alert.of(current_user)
    @product = Product.where("name ILIKE ?", "%#{params[:query]}%").first
  end

  def update
  end

  def destroy
    @alert = Alert.find(params[:id])
    @alert.destroy
    redirect_to alerts_path
  end

private

  def alert_params
    params.require(:alert).permit(:target_price, :by_email, :by_text_message)
  end

end
