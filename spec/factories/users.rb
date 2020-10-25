FactoryBot.define do

  factory :user do
    nickname              {"abe"}
    email                 {"kkk@aheahe.com"}
    password              {"00000000a"}
    password_confirmation {"00000000a"}
    family_name_kanji     {"山本"}
    first_name_kanji      {"太郎"}
    family_name_kana      {"やまもと"}
    first_name_kana       {"たろう"}
    birthday              {"20000101"}
  end

end