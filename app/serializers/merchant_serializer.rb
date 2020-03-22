class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :revenue
end
