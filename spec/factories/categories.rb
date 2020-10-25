FactoryBot.define do

  factory :category do
    name {"レディース"}
    ancestry {nil}

    after(:build) do |category|
      category.save
      child_category = category.children.create(name: category.name)
      grand_child_category = child_category.children.create(name: child_category.name)

      category.id = grand_child_category.id
    end

  end

end