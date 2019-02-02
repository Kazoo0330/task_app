FactoryBot.define do

  factory :user do
    name { 'test_user' }
    email { 'test@example.com' }
    password { 'password' }
  end

  factory :user2, class: User do
    name { 'test_user2' }
    email { 'test2@example.com' }
    password { 'password' }
  end

  factory :admin_user, class: User do
    name { 'admin_user' }
    email { 'admin@example.com' }
    admin { true }
    password { 'password' }
  end

end
