# frozen_string_literal: true

require 'sales_taxes/calculator'

module Shopping
  class Item
    attr_reader :quantity, :description, :unit_base_price

    def initialize(quantity:, description:, unit_base_price:)
      @quantity = quantity.to_f
      @description = description
      @unit_base_price = unit_base_price.to_f
    end

    def shelf_price
      (sales_taxes + unit_base_price * quantity).round(2)
    end

    def sales_taxes
      SalesTaxes::Calculator.call(item: self)
    end
  end
end
