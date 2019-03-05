class CreateLowestPrices < ActiveRecord::Migration[5.2]
  def change
    create_table :lowest_prices do |t|
      t.references :price, foreign_key: true
      t.references :alert, foreign_key: true

      t.timestamps
    end
  end
end
