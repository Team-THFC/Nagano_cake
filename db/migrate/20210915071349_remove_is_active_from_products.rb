class RemoveIsActiveFromProducts < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :is_active, :boolean
  end
end
