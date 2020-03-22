require 'rails_helper'

RSpec.describe 'Item find endpoint' do
  it 'can find  an item based on name parameters' do
    merchant = create(:merchant)
    item_1 = create(:item, name: 'Stethoscope', merchant: merchant)
    item_2 = create(:item, name: 'Stereoscope', merchant: merchant)

    get '/api/v1/items/find?name=ste'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data].count).to eq(1)
    expect(json[:data].first[:id]).to eq(item_1.id.to_s)
    expect(json[:data].first[:attributes]).to have_key(:name)
    expect(json[:data].first[:attributes]).to have_key(:unit_price)
    expect(json[:data].first[:attributes]).to have_key(:description)
    expect(json[:data].first[:attributes][:name]).to eq(item_1.name)
  end

  it 'can get all items based on name and description parameters' do
    merchant = create(:merchant)
    item_1 = create(:item, name: 'Stethoscope', description: 'A doctor item', merchant: merchant)
    item_2 = create(:item, name: 'Stereoscope', description: 'Another doctors item', merchant: merchant)

    get '/api/v1/items/find_all?name=ste&description=doctor'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data].count).to eq(2)

    expect(json[:data].first[:id]).to eq(item_1.id.to_s)
    expect(json[:data].first[:attributes]).to have_key(:name)
    expect(json[:data].first[:attributes]).to have_key(:unit_price)
    expect(json[:data].first[:attributes]).to have_key(:description)
    expect(json[:data].first[:attributes][:name]).to eq(item_1.name)

    expect(json[:data].last[:id]).to eq(item_2.id.to_s)
    expect(json[:data].last[:attributes]).to have_key(:name)
    expect(json[:data].last[:attributes]).to have_key(:unit_price)
    expect(json[:data].last[:attributes]).to have_key(:description)
    expect(json[:data].last[:attributes][:name]).to eq(item_2.name)
  end
end
