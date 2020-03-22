class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices

  def self.search_for(search_params)
    where(search_params.keys.map { |param| "#{param} ILIKE '%#{search_params[param]}%'" }
      .join(' AND '))
  end

  def self.get_merchant_by(search_params)
    search_for(search_params).limit(1)
  end

  def self.get_all_merchants_by(search_params)
    search_for(search_params)
  end

  def self.most_revenue(quantity)
    all.sort_by do |merchant|
      merchant.revenue
    end.reverse[0..quantity.to_i-1]
  end

  def revenue
    transactions
      .where(result: 'success')
      .joins(:invoice_items)
      .sum('invoice_items.quantity * invoice_items.unit_price')
  end
end

# Merchant.items.joins(:transactions)
#               .where(transactions: { result: :success})
#               .select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
#               .group(:id).order('revenue', :DESC)
#               .limit(params[:quantity])
