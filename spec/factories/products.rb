FactoryGirl.define do

  sequence :product_name do |n|
    "Mission Impossible #{n} (DVD)"
  end
  factory :product do
    name { generate(:product_name) }
    quantity 1
  end

end
