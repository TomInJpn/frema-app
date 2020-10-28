FactoryBot.define do

  factory :user do
    nickname              {"abe"}
    email                 {"kkk@hogehoge.com"}
    password              {"00000000a"}
    password_confirmation {"00000000a"}
    family_name_kanji     {"山本"}
    first_name_kanji      {"太郎"}
    family_name_kana      {"やまもと"}
    first_name_kana       {"たろう"}
    birthday              {"20000101"}
  end

  factory :buyer, class: User do
    nickname              {"yabe"}
    email                 {"kkk@aheahe.com"}
    password              {"00000000b"}
    password_confirmation {"00000000b"}
    family_name_kanji     {"岡本"}
    first_name_kanji      {"太郎"}
    family_name_kana      {"おかもと"}
    first_name_kana       {"たろう"}
    birthday              {"19990202"}
  end

end