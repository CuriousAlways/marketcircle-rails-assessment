FactoryBot.define do
  factory :detail do
    title { ::Detail::TITLE.sample }
    age { ::Faker::Number.number(digits: 2) }
    email { ::Faker::Internet.email }
    phone { ::Faker::PhoneNumber.phone_number }

    person { association :person }
  end
end
