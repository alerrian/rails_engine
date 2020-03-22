class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.where())
  end
end
