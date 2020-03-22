require 'rails_helper'

RSpec.describe 'Merchant find endpoint' do
  it 'can find a merchant based on name parameters' do
    merchant_1 = create(:merchant, name: 'Steve')
    create(:merchant, name: 'Joe')
    create(:merchant, name: 'Steph')

    get '/api/v1/merchants/find?name=ste'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data].count).to eq(1)
    expect(json[:data].first[:id]).to eq(merchant_1.id.to_s)
    expect(json[:data].first[:attributes]).to have_key(:name)
    expect(json[:data].first[:attributes][:name]).to eq(merchant_1.name)
  end

  it 'can get all merchants based on name parameters' do
    merchant_1 = create(:merchant, name: 'Steve')
    merchant_2 = create(:merchant, name: 'Joe')
    merchant_3 = create(:merchant, name: 'Steph')

    get '/api/v1/merchants/find_all?name=ste'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data].count).to eq(2)
    expect(json[:data].first[:id]).to eq(merchant_1.id.to_s)
    expect(json[:data].first[:attributes]).to have_key(:name)
    expect(json[:data].first[:attributes][:name]).to eq(merchant_1.name)

    expect(json[:data].last[:id]).to eq(merchant_3.id.to_s)
    expect(json[:data].last[:attributes]).to have_key(:name)
    expect(json[:data].last[:attributes][:name]).to eq(merchant_3.name)
  end
end
