# frozen_string_literal: true

require 'spec_helper'
require 'shopping/basket'
require 'shopping/item'

RSpec.describe Shopping::Basket do
  subject(:basket) { described_class.new(items:) }

  let(:books) { Shopping::Item.new(quantity: 2, description: 'book', unit_base_price: 12.49) }
  let(:music_cd) { Shopping::Item.new(quantity: 1, description: 'music CD', unit_base_price: 14.99) }

  let(:items) { [books, music_cd] }

  describe '#total_price' do
    subject(:result) { basket.total_price }

    let(:expected_price) { 46.65 }

    before do
      allow(books).to receive(:shelf_price).and_return(30.0)
      allow(music_cd).to receive(:shelf_price).and_return(16.65)
    end

    it 'returns the sum of all items total price' do
      expect(result).to eq(expected_price)
    end
  end

  describe '#sales_taxes' do
    subject(:result) { basket.sales_taxes }

    let(:expected_taxes) { 1.25 }

    before do
      allow(books).to receive(:sales_taxes).and_return(1.20)
      allow(music_cd).to receive(:sales_taxes).and_return(0.05)
    end

    it 'returns the sum of all items total price' do
      expect(result).to eq(expected_taxes)
    end
  end

  describe '#add_item' do
    let(:new_item) { Shopping::Item.new(quantity: 1, description: 'chocolate bar', unit_base_price: 5.50) }

    before do
      basket.add_item(new_item)
    end

    it 'contains the new item' do
      expect(basket.items.last).to eq(new_item)
    end
  end
end
