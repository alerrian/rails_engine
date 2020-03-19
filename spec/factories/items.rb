FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Commerce.department }
    unit_price { 10.00 }
    merchant
  end
end
