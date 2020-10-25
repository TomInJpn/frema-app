FactoryBot.define do

  factory :image do
    image {File.open("#{Rails.root}/public/images/sample.jpg")}
  end

end