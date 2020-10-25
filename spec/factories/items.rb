FactoryBot.define do

  factory :item do
    association :user
    association :category
    name                  {"湯呑"}
    brand                 {"吉野家"}
    description           {"吉野家の景品"}
    condition_id          {Condition.all.sample.id}
    shipment_fee_id       {ShipmentFee.all.sample.id}
    prefecture_id         {Prefecture.all.sample.id}
    shipment_schedule_id  {ShipmentSchedule.all.sample.id}
    stock                 {10}
    price                 {600}
    after(:build) do |item|
      item.images << build(:image)
    end
  end

end