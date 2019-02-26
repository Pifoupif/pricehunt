class ChangeColumnOnPrice < ActiveRecord::Migration[5.2]
  def change
    change_column :prices, :price, :integer
  end
end
