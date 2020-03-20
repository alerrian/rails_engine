class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items

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
end
