# frozen_string_literal: true

module Shopping
  class Basket
    attr_reader :items

    def initialize(items: [])
      @items = items
    end

    def add_item(item)
      items.push(item)
    end

    def total_price
      items.map(&:shelf_price).sum
    end

    def sales_taxes
      items.map(&:sales_taxes).sum
    end
  end
end
