FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    quantity { 1 }
    unit_price { item.unit_price }
  end
end
