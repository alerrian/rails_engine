require 'rails_helper'

describe 'Customers API' do
  it 'sends an customer INDEX' do
    create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body, symbolize_names: true)

    expect(customers[:data].count).to eq(3)
  end

  it 'sends a customer SHOW' do
    id = create(:customer).id.to_s

    get "/api/v1/customers/#{id}"

    customer = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(customer[:data][:id]).to eq(id)
  end

  it 'can CREATE a customer' do
    customer_params = { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name }

    post '/api/v1/customers', params: { customer: customer_params }

    customer = Customer.last

    expect(response).to be_successful
    expect(customer.first_name).to eq(customer_params[:first_name])
    expect(customer.last_name).to eq(customer_params[:last_name])
  end

  it 'can UPDATE a customer' do
    id = create(:customer).id.to_s

    previous_first_name = Customer.last.first_name
    customer_params = { first_name: 'New' }

    put "/api/v1/customers/#{id}", params: { customer: customer_params }
    customer = Customer.find_by(id: id)

    expect(response).to be_successful
    expect(customer.first_name).to_not eq(previous_first_name)
    expect(customer.first_name).to eq('New')
  end

  it 'can DESTROY a customer' do
    customer = create(:customer)

    expect(Customer.count).to eq(1)

    delete "/api/v1/customers/#{customer.id}"

    expect(response).to be_successful
    expect(Customer.count).to eq(0)
    expect { Customer.find(customer.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
