require 'rails_helper'

describe 'Merchants API' do
  it 'sends an merchant INDEX' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(3)
  end

  it 'sends a merchants SHOW' do
    id = create(:merchant).id.to_s

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(merchant[:data][:id]).to eq(id)
  end

  it 'sends a merchants CREATE' do
    merchant_params = { name: Faker::Company.name }

    post '/api/v1/merchants', params: { merchant: merchant_params }

    merchant = Merchant.last

    expect(response).to be_successful
    expect(merchant.name).to eq(merchant_params[:name])
  end
end
