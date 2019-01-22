FactoryBot.define do

  # factory :user do
  #   sequence(:name) { |n| "TEST_NAME_#{n}" }
  #   # sequence(:email) { |n| "test#{n}@example.com" }
  #   sequence(:email) { "test@example.com" }
  #   sequence(:password) { "password" }
  # end

  factory :user do
    sequence(:name) { |n| "TEST_NAME#{n}"}
    sequence(:email) { |n| "TEST#{n}@example.com"}
    sequence(:password) { "password" }
  end

end
