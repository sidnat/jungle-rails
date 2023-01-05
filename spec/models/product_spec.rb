require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'will successfully save as a Product' do
      @category = Category.new(name: 'Big plants')
      @product = Product.new(name: 'Planty Plant', price: 1000, quantity: 36, category: @category)
      @product.save!
      expect(@product.id).to be_present
    end

    it 'is not valid without a name' do
      @category = Category.new(name: 'Big plants')
      @product = Product.new(name: nil, price: 1000, quantity: 36, category: @category)
      expect(@product).to be_invalid
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'is not valid without a price' do
      @category = Category.new(name: 'Big plants')
      @product = Product.new(name: 'Planty Plant', quantity: 36, category: @category)
      expect(@product).to be_invalid
      expect(@product.errors.full_messages).to include("Price is not a number")
    end

    it 'is not valid without a quantity' do
      @category = Category.new(name: 'Big plants')
      @product = Product.new(name: 'Planty Plant', price: 1000, quantity: nil, category: @category)
      expect(@product).to be_invalid
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'is not valid without a category' do
      @product = Product.new(name: 'Planty Plant', price: 1000, quantity: 36, category: nil)
      expect(@product).to be_invalid
      expect(@product.errors.full_messages).to include("Category must exist")
    end
  end
end