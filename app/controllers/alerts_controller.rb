class AlertsController < ApplicationController
  def create
    @alert = Alert.new(alert_params)
    @alert.user = current_user
    @alert.product_id = params[:product_id]
    if @alert.save
      redirect_to alert_index_path
    else
      raise
    end
  end

  def edit
  end

  def show
    @alert = Alert.find(params[:id])
  end

  def index
    @user_alerts = Alert.joins(:product).where(:products => {:user => current_user })
  end

  def update
  end

  def destroy
  end

private

  def alert_params
    params.require(:alert).permit(:target_price)
  end

end
