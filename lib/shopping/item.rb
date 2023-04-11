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
      (unit_sales_taxes + unit_base_price).round(2) * quantity
    end

    def unit_sales_taxes
      SalesTaxes::Calculator.call(item: self)
    end

    def sales_taxes
      (unit_sales_taxes * quantity).round(2)
    end
  end
end
