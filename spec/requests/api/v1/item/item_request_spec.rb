require 'rails_helper'

RSpec.describe 'Item relationship endpoints' do
  it 'can send back a merchant for an item' do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to be_successful
    merchant_json = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_json[:data][:attributes][:name]).to eq(merchant.name)
  end
end
