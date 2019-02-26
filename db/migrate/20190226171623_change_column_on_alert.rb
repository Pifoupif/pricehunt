class ChangeColumnOnAlert < ActiveRecord::Migration[5.2]
  def change
   change_column :alerts, :target_price, :integer

  end
end
