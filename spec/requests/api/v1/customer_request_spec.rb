require 'rails_helper'

describe 'CUSTOMERS API' do
  it 'sends a list of CUSTOMERS' do
    create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers.count).to eq(3)
  end
end
