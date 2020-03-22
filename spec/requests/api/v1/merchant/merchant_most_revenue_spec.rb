require 'rails_helper'

RSpec.describe 'Merchant Most Revenue' do
  it 'can get merchants with the most revenue' do
    merchant_1 = create(:merchant, name: 'First Merchant')
    merchant_2 = create(:merchant, name: 'Second Merchant')
    merchant_3 = create(:merchant, name: 'Third Merchant')
    merchant_4 = create(:merchant, name: 'Fourth Merchant')

    invoice_items_1 = create_list(:invoice_item, 3, quantity: 1, unit_price: 50)
    invoice_items_2 = create_list(:invoice_item, 2, quantity: 10, unit_price: 10)

    invoice_items_1.each do |invoice_item|
      invoice_item.invoice.update(merchant_id: merchant_1.id)
      create(:transaction, invoice: invoice_item.invoice, result: 'success')
    end

    invoice_items_2.each do |invoice_item|
      invoice_item.invoice.update(merchant_id: merchant_2.id)
      create(:transaction, invoice: invoice_item.invoice, result: 'success')
    end

    get '/api/v1/merchants/most_revenue?quantity=2'

    expect(response).to be_successful

    merchants_json = JSON.parse(response.body, symbolize_names: true)

    expect(merchants_json[:data].count).to eq(2)
    expect(merchants_json[:data].first[:attributes][:name]).to eq('Second Merchant')
    expect(merchants_json[:data].last[:attributes][:name]).to eq('First Merchant')
  end
end
