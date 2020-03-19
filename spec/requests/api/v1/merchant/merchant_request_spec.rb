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
end
