# frozen_string_literal: true

require 'spec_helper'
require 'sales_taxes/product_categorizer'

RSpec.describe SalesTaxes::ProductCategorizer do
  describe '.product_type' do
    subject(:result) { described_class.product_type(description) }

    describe 'when description contains a food keyword' do
      let(:description) { 'imported boxes of chocolates' }

      it 'classifies it as food' do
        expect(result).to eq(:food)
      end
    end

    describe 'when description contains a medical product keyword' do
      let(:description) { 'packet of headache pills' }

      it 'classifies it as medical' do
        expect(result).to eq(:medical)
      end
    end

    describe 'when description contains a book product keyword' do
      let(:description) { 'book' }

      it 'classifies it as book' do
        expect(result).to eq(:book)
      end
    end

    describe 'when product cannot be categorized' do
      let(:description) { 'imported bottle of perfume' }

      it 'classifies it as general' do
        expect(result).to eq(:general)
      end
    end
  end

  describe '.imported?' do
    subject(:result) { described_class.imported?(description) }

    describe 'when description says its imported' do
      let(:description) { 'imported boxes of chocolates' }

      it 'returns true' do
        expect(result).to eq(true)
      end
    end

    describe 'when description does not say its imported' do
      let(:description) { 'bottle of perfume' }

      it 'returns true' do
        expect(result).to eq(false)
      end
    end
  end
end
