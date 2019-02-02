require 'rails_helper'

RSpec.feature "User functionalities", type: :feature do

  def login
    visit new_user_session_path
    fill_in 'Email', with: "test@example.com"
    fill_in 'Password', with: 'password'
    click_on 'Log in'
  end

  def second_user_login
    visit new_user_session_path
    fill_in 'Email', with: "test2@example.com"
    fill_in 'Password', with: 'password'
    click_on 'Log in'
  end

  def admin_user_login
    visit new_user_session_path
    fill_in 'Email', with: "admin@example.com"
    fill_in 'Password', with: 'password'
    click_on 'Log in'
  end

  def logout
    visit tasks_path
    click_link '❯❯❯ ログアウト'
  end

 background do

    user = FactoryBot.create(:user)
    # second_user = FactoryBot.create(:user, name: 'test_user2', email: 'test2@example.com', password: 'password')

    second_user = FactoryBot.create(:user2)

    admin = FactoryBot.create(:admin_user)

    FactoryBot.create(:task, title: 'first task', content: 'first task content', expires_on: Time.zone.today + 1, status: Task::statuses['未着手🦖'], priority: Task::priorities['あとでいいや🙈'], user: user)
   FactoryBot.create(:task, title: 'second user task', content: 'second user task content', expires_on: Time.zone.today + 9, status: Task::statuses['完了✅'], priority: Task::priorities['今すぐやらなきゃ🙊'], user: second_user)

    login

  end

  third_user = FactoryBot.create(:user, name: 'test_user3', email: 'test3@example.com', password: 'password')

  feature 'throughout feature spec test requires user to be logged in' do

    scenario "(1)check if it's able to logout" do
      visit "/"
      click_link 'マイページ👶'
      expect(page).to have_content 'test@example.com'

      logout
      expect(page).to have_content 'ログアウトしました。'
    end

    scenario "(2)check if it's able to see new session path" do
      logout
      expect(page).to have_content 'ログアウトしました。'

      expect(page).to have_content 'Remember me'
    end

    scenario "(3)ensure that the page should contain current_user's info."  do
      expect(page).to have_content 'ログインしました。'
      expect(page).to have_content '現在ログイン中のユーザー'
      expect(page).to have_content 'test_user'
    end

    scenario "(4)current_user cannot see other's info." do

      # visit user_path(second_user)
      visit user_path(third_user)
      expect(page).to have_content 'そんな人はいません🙅'

    end

    scenario '(5) ensure that the user show action functionality properly working' do
      visit tasks_path
      click_link 'マイページ👶'
      expect(page).to have_content 'メールアドレス📧'
      expect(page).to have_content 'test@example.com'

      visit user_path(third_user)
      expect(page).to have_content 'そんな人はいません🙅'
    end

    scenario '(6) user functionality should  allow current_user to logout' do
      visit tasks_path
      click_link 'マイページ👶'
      expect(page).to have_content 'test@example.com'

      logout
      expect(page).to have_content 'ログアウトしました。'
    end

    scenario '(7) logged in user should be unable to visit the user registration page' do
      visit tasks_path
      click_link 'マイページ👶'
      visit new_user_registration_path
      expect(page).to have_content 'すでにログインしています。'
    end

    scenario '(8) the second user should be existing' do

      logout

      second_user_login #second user login method prepared at the  first.

      visit tasks_path
      click_link 'マイページ👶'
      visit new_user_registration_path
      expect(page).to have_content 'test_user2'
    end

    scenario '(9) admin user should be able to see the user index page' do

      logout
      admin_user_login

      visit admin_users_path
      expect(page).to have_content 'test_user'
      expect(page).to have_content 'test_user2'
      expect(page).to have_content 'admin_user'
      expect(page).to have_content 'ADMIN'
    end

    scenario '(10) every single user shoould not be able to see others info' do

      visit user_path(third_user)
      expect(page).to have_content 'そんな人はいません🙅'
    end

    scenario '(11) admin user ought to be able to create a new user with an admin role' do

      logout
      admin_user_login
      visit admin_users_path

      click_on '新規ユーザー作成🌟'
      expect(page).to have_content 'Password confirmation'

      fill_in 'Name', with: 'created_admin_user'
      fill_in 'Email', with: 'created_admin_user@example.com'
      check 'Admin'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'

      click_on '登録する'

      expect(page).to have_content 'true'
      expect(page).to have_content 'created_admin_user'
    end

    scenario '(12) admin user ought to be able to create new user with a normal user role' do
      logout
      admin_user_login
      visit admin_users_path

      click_on '新規ユーザー作成🌟'
      expect(page).to have_content 'Password confirmation'

      fill_in 'Name', with: 'created_normal_user'
      fill_in 'Email', with: 'created_normal_user@example.com'
      uncheck 'Admin'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'

      click_on '登録する'

      expect(page).to have_content 'false'
      expect(page).to have_content 'created_normal_user'
    end

  end
end
