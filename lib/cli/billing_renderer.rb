# frozen_string_literal: true

module CLI
  class BillingRenderer
    attr_reader :shopping_basket

    def initialize(shopping_basket:)
      @shopping_basket = shopping_basket
    end

    def render_basket_bill
      lines = shopping_basket.items.map do |item|
        format_shopping_item_line(item)
      end

      lines.push(total_taxes_line(shopping_basket))
      lines.push(total_price_line(shopping_basket))

      lines.join("\n")
    end

    private

    def format_shopping_item_line(item)
      "#{item.quantity.to_i} #{item.description}: #{'%.2f' % item.shelf_price}"
    end

    def total_taxes_line(basket)
      "Sales Taxes: #{'%.2f' % basket.sales_taxes}"
    end

    def total_price_line(basket)
      "Total: #{'%.2f' % basket.total_price}"
    end
  end
end
