class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price

  belongs_to :merchant

  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  def self.search_for(search_params)
    where(search_params.keys.map { |param| "#{param} ILIKE '%#{search_params[param]}%'" }
      .join(' AND '))
  end

  def self.get_item_by(search_params)
    search_for(search_params).limit(1)
  end

  def self.get_all_items_by(search_params)
    search_for(search_params)
  end
end
