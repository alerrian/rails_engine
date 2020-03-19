require 'rails_helper'

describe 'Items API' do
  it 'sends a list of items' do
    merchant_id = create(:merchant).id
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(3)

    items[:data].each do |item|
      expect(item[:type]).to eq('item')
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes]).to have_key(:merchant_id)
    end
  end

  it 'can get an item by id' do
    id = create(:item).id.to_s

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(item[:data][:id]).to eq(id)
  end

  it 'can create a new item' do
    merchant = create(:merchant)
    item_params = {
      name: 'New Item',
      description: 'A new Item',
      unit_price: 15.00,
      merchant_id: merchant.id
    }

    post '/api/v1/items', params: item_params

    last_item = Item.last

    expect(response).to be_successful
    expect(last_item.name).to eq(item_params[:name])
    expect(last_item.description).to eq(item_params[:description])
  end
end
