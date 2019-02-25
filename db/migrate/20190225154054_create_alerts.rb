class CreateAlerts < ActiveRecord::Migration[5.2]
  def change
    create_table :alerts do |t|
      t.references :product, foreign_key: true
      t.references :user, foreign_key: true
      t.numeric :target_price

      t.timestamps
    end
  end
end
