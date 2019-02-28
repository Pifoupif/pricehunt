class AddColumnToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :denich_id, :string
  end
end
