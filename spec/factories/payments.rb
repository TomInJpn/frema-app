FactoryBot.define do

  factory :payment do
    charge_id   {"ch_****************************"}
    association :user
    association :item
    quantity    {1}
  end

end
