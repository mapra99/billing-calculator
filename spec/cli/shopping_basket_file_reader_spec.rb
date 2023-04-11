# frozen_string_literal: true

require 'spec_helper'
require 'cli/shopping_basket_file_reader'
require 'shopping/basket'

RSpec.describe CLI::ShoppingBasketFileReader do
  describe '.parse_file' do
    subject(:result) { described_class.parse_file(uri) }

    let(:uri) { 'test_cases/basket_1.txt' }

    it 'returns a shopping basket instance' do
      expect(result).to be_a Shopping::Basket
    end

    it 'returns 3 basket items' do
      expect(result.items.size).to eq(3)
    end

    it 'returns basket items instances' do
      expect(result.items).to all(be_a(Shopping::Item))
    end

    describe 'the first item' do
      let(:first_item) { result.items.first }

      it 'has the expected quantity' do
        expect(first_item.quantity).to eq(2)
      end

      it 'has the expected description' do
        expect(first_item.description).to eq('book')
      end

      it 'has the expected price' do
        expect(first_item.unit_base_price).to eq(12.49)
      end
    end
  end
end
