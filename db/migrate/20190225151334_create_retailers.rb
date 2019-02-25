class CreateRetailers < ActiveRecord::Migration[5.2]
  def change
    create_table :retailers do |t|
      t.string :name
      t.string :logo
      t.numeric :rating

      t.timestamps
    end
  end
end
