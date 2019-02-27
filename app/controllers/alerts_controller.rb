class AlertsController < ApplicationController
  def create
    @alert = Alert.new(alert_params)
    @alert.user = current_user
    @alert.product_id = params[:product_id]
    raise
    if @alert.save
      respond_to do |format|
        format.html { redirect_to product_path(params[:product_id]) }
        format.js
      end
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
    @alert = Alert.find(params[:id])
  end

  def index
    @user_alerts = Alert.where(user: current_user)
  end

  def update
  end

  def destroy
  end

private

  def alert_params
    params.require(:alert).permit(:target_price, :by_email, :by_text_message)
  end

end
