require 'rails_helper'

RSpec.describe 'Merchant Most Revenue' do
  it 'can get merchants with the most revenue' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)
    merchant_4 = create(:merchant)

    get '/api/v1/merchants/most_revenue?quantity=2'

    expect(response).to be_successful

    require 'pry'; binding.pry
  end
end
