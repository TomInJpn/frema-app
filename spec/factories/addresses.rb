FactoryBot.define do

  factory :address do
    family_name_kanji     {"鈴木"}
    first_name_kanji      {"一郎"}
    family_name_kana      {"すずき"}
    first_name_kana       {"いちろう"}
    post_number           {"810-0801"}
    prefecture_id         {Prefecture.all.sample.id}
    city                  {"福岡市博多区中洲"}
    block_number          {"１−１"}
    apartment_name        {"tech福岡801号室"}
    phone_number          {"09012345678"}
  end

end