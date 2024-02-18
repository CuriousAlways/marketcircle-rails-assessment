FactoryBot.define do
  factory :person do
    name { ::Faker::Name.name }

    trait :with_detail do
      detail { association :detail, person: instance }
    end
  end
end
