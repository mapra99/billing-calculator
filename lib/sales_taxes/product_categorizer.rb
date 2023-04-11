# frozen_string_literal: true

module SalesTaxes
  class ProductCategorizer
    FOOD_TYPE = :food
    BOOK_TYPE = :book
    MEDICAL_TYPE = :medical
    GENERAL_TYPE = :general

    class << self
      FOOD_KEYWORDS = %w[food chocolate].freeze
      BOOKS_KEYWORDS = %w[book].freeze
      MEDICAL_PRODUCT_KEYWORDS = %w[drug pill].freeze

      IMPORTED_KEYWORD = 'imported'

      def product_type(description)
        return FOOD_TYPE if check_keywords_presence(description, FOOD_KEYWORDS)
        return BOOK_TYPE if check_keywords_presence(description, BOOKS_KEYWORDS)
        return MEDICAL_TYPE if check_keywords_presence(description, MEDICAL_PRODUCT_KEYWORDS)

        GENERAL_TYPE
      end

      def imported?(description)
        description.include?(IMPORTED_KEYWORD)
      end

      private

      def check_keywords_presence(description, keywords)
        keywords.any? { |kwd| description.include?(kwd) }
      end
    end
  end
end
