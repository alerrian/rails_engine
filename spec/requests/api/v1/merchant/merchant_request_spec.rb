require 'rails_helper'

RSpec.describe 'Item relationship endpoints' do
  it 'can send back a merchant for an item' do
    merchant = create(:merchant)

    100.times do
      create(:item, merchant: merchant)
    end

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful
    items_json = JSON.parse(response.body, symbolize_names: true)

    expect(items_json[:data].length).to eq(100)
  end

  it 'can send back a merchant revenue' do
    merchant_1 = create(:merchant)

    invoice_items_1 = create_list(:invoice_item, 3, quantity: 1, unit_price: 50)

    invoice_items_1.each do |invoice_item|
      invoice_item.invoice.update(merchant_id: merchant_1.id)
      create(:transaction, invoice: invoice_item.invoice, result: 'success')
    end

    get "/api/v1/merchants/#{merchant_1.id}/revenue"

    expect(response).to be_successful
    merchant_revenue_json = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_revenue_json[:data][:attributes][:revenue]).to eq('150.0')
  end
end
