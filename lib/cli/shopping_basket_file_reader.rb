# frozen_string_literal: true

require 'cli/errors/line_parsing_error'
require 'shopping/basket'
require 'shopping/item'

module CLI
  class ShoppingBasketFileReader
    class << self
      FILE_LINE_PATTERN = /^(\d+)\s(.+)\sat\s(.+)$/

      InputLine = Struct.new(:quantity, :description, :price)

      def parse_file(uri)
        shopping_basket = Shopping::Basket.new

        File.open(uri).each do |line|
          input_line = parse_line(line)

          shopping_item = Shopping::Item.new(
            quantity: input_line.quantity,
            description: input_line.description,
            unit_base_price: input_line.price
          )

          shopping_basket.add_item(shopping_item)
        end

        shopping_basket
      end

      private

      def parse_line(line)
        match_data = line.match(FILE_LINE_PATTERN)
        raise LineParsingError, line if match_data.nil?

        InputLine.new(match_data[1], match_data[2], match_data[3])
      end
    end
  end
end
