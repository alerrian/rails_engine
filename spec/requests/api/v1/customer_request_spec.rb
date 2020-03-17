require 'rails_helper'

describe 'CUSTOMERS API' do
  it 'sends an INDEX of CUSTOMERS' do
    create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body, symbolize_names: true)

    expect(customers[:data].count).to eq(3)
  end

  it 'sends a SINGLE CUSTOMER' do
    id = create(:customer).id.to_s

    get "/api/v1/customers/#{id}"

    customer = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(customer[:data][:id]).to eq(id)
  end
end
