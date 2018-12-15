FactoryBot.define do

  factory :user do
    sequence(:name) { |n| "TEST_NAME_#{n}" }
    # sequence(:email) { |n| "test#{n}@example.com" }
    sequence(:email) { "test@example.com" }
    sequence(:password) { "password" }
    # birthday '2017-01-01'
  end

end
