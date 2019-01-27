shared_examples :sign_in do
  include Devise::Test::IntegrationHelpers

  let(:current_user) { create :user }

  before do
    sign_in current_user
  end
end

# module Features

#   module SessionHelpers

#     def sign_up_with(email, password, confirmation)
#       visit new_user_registration_path
#       fill_in 'Email', with: "test@example.com"
#       fill_in 'Password', with: 'password'
#       fill_in "Password confirmation", with: 'password'
#       # fill_in "Email", with: email
#       # fill_in "Password", with: password
#       # fill_in "Password confirmation", with: confirmation
#       click_button "Sign up"
#     end

#     def sign_in(email, password)
#       visit new_user_session_path
#       fill_in 'Email', with: "test@example.com"
#       fill_in 'Password', with: 'password'
#       click_on 'Log in'
#       # fill_in "Email", with: email
#       # fill_in "Password", with: password
#       # click_button "Log in"
#     end
#   end
# end
