class AddIsDiscountedToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :is_discounted, :boolean, default: false
  end
end
