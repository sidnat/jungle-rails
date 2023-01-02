class AddDiscountCentsToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :sale_percent_off, :integer
  end
end
