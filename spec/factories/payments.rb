FactoryBot.define do

  factory :payment do
    charge_id   {"ch_****************************"}
    association :user
    association :buyer
    association :item
    quantity    {10}
    payment    {1000}
  end

end
