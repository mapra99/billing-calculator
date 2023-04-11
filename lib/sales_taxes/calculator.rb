# frozen_string_literal: true

require 'sales_taxes/product_categorizer'

module SalesTaxes
  class Calculator
    class << self
      NON_TAXEABLE_PRODUCT_TYPES = [
        ProductCategorizer::FOOD_TYPE,
        ProductCategorizer::MEDICAL_TYPE,
        ProductCategorizer::BOOK_TYPE
      ].freeze

      def call(item:)
        taxes = 0.0
        taxes += calculate_basic_tax(item)
        taxes += calculate_import_tax(item)

        (taxes * 20).ceil / 20.0 # round up to nearest 0.05
      end

      private

      def calculate_basic_tax(item)
        product_type = ProductCategorizer.product_type(item.description)
        return 0 if NON_TAXEABLE_PRODUCT_TYPES.include?(product_type)

        0.10 * item.unit_base_price
      end

      def calculate_import_tax(item)
        imported = ProductCategorizer.imported?(item.description)
        return 0 unless imported

        0.05 * item.unit_base_price
      end
    end
  end
end
