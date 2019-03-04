class AddOfferTodayToAlerts < ActiveRecord::Migration[5.2]
  def change
    add_column :alerts, :offer_today, :boolean, default: false
  end
end
