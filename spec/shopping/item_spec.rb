# frozen_string_literal: true

require 'spec_helper'
require 'shopping/item'
require 'sales_taxes/calculator'

RSpec.describe Shopping::Item do
  subject(:item) { described_class.new(quantity:, description:, unit_base_price:) }

  let(:quantity) { 3 }
  let(:description) { 'super amazing product' }
  let(:unit_base_price) { 15.35 }

  describe '#shelf_price' do
    subject(:result) { item.shelf_price }

    before do
      allow(SalesTaxes::Calculator).to receive(:call).and_return(4.62)
    end

    it 'returns the total shelf price for the item' do
      expect(result).to eq(50.67)
    end
  end

  describe '#sales_taxes' do
    subject(:result) { item.sales_taxes }

    before do
      allow(SalesTaxes::Calculator).to receive(:call).and_return(4.62)
    end

    it 'returns the total sales taxes for the item' do
      expect(result).to eq(4.62)
    end
  end
end
