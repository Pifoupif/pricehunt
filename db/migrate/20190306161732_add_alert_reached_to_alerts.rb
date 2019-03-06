class AddAlertReachedToAlerts < ActiveRecord::Migration[5.2]
  def change
    add_column :alerts, :alert_reach, :boolean, default: false
  end
end
