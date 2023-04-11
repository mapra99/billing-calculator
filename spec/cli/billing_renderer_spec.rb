# frozen_string_literal: true

require 'spec_helper'
require 'cli/billing_renderer'
require 'shopping/basket'
require 'shopping/item'

RSpec.describe CLI::BillingRenderer do
  subject(:renderer) { described_class.new(shopping_basket:) }

  let(:shopping_basket) { Shopping::Basket.new(items: shopping_items) }
  let(:shopping_items) do
    [
      Shopping::Item.new(quantity: 2, description: 'book', unit_base_price: 12.49),
      Shopping::Item.new(quantity: 1, description: 'music CD', unit_base_price: 14.99),
      Shopping::Item.new(quantity: 1, description: 'chocolate bar', unit_base_price: 0.85)
    ]
  end

  describe '#render_basket_bill' do
    subject(:result) { renderer.render_basket_bill }

    let(:expected_string) do
      <<~BILL
        2 book: 24.98
        1 music CD: 16.49
        1 chocolate bar: 0.85
        Sales Taxes: 1.50
        Total: 42.32
      BILL
    end

    it 'returns the bill to be renderer' do
      expect(result).to eq(expected_string.chomp)
    end
  end
end
