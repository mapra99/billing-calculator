# frozen_string_literal: true

require 'spec_helper'
require 'sales_taxes/calculator'
require 'shopping/item'

RSpec.describe SalesTaxes::Calculator do
  describe '.call' do
    subject(:result) { described_class.call(item: item) }

    describe 'when its a national product with basic tax excemption' do
      let(:item) { Shopping::Item.new(quantity: 1, description: 'packet of headache pills', unit_base_price: 9.75) }

      it { expect(result.round(2)).to eq(0) }
    end

    describe 'when its an imported product with basic tax excemption' do
      let(:item) { Shopping::Item.new(quantity: 1, description: 'imported box of chocolates', unit_base_price: 10.00) }

      it { expect(result.round(2)).to eq(0.50) }
    end

    describe 'when its an imported product without basic tax excemption' do
      let(:item) { Shopping::Item.new(quantity: 1, description: 'imported bottle of perfume', unit_base_price: 27.99) }

      it { expect(result.round(2)).to eq(4.20) }
    end

    describe 'when its a national product without basic tax excemption' do
      let(:item) { Shopping::Item.new(quantity: 1, description: 'bottle of perfume', unit_base_price: 18.99) }

      it { expect(result.round(2)).to eq(1.9) }
    end
  end
end
