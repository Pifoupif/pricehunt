class AddColumnToAlerts < ActiveRecord::Migration[5.2]
  def change
    add_column :alerts, :by_email, :boolean, default: false
    add_column :alerts, :by_text_message, :boolean, default: false
  end
end
