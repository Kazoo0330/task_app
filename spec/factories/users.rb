FactoryBot.define do

  factory :user do
    sequence(:name) { |n| "TEST_NAME_#{n}" }
    birthday '2017-01-01'
  end

end
