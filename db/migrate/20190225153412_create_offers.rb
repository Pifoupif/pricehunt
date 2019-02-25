class CreateOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :offers do |t|
      t.references :product, foreign_key: true
      t.references :retailer, foreign_key: true

      t.timestamps
    end
  end
end
