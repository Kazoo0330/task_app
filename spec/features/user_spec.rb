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

 background do

    user = FactoryBot.create(:user)
    second_user = FactoryBot.create(:user, name: 'test_user2', email: 'test2@example.com', password: 'password')

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

      click_link '❯❯❯ ログアウト'
      expect(page).to have_content 'ログアウトしました。'
    end

    scenario "(2)check if it's able to see new session path" do
      click_link '❯❯❯ ログアウト'
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

      click_link '❯❯❯ ログアウト'
      expect(page).to have_content 'ログアウトしました。'
    end

    scenario '(7) logged in user should be unable to visit the user registration page' do
      visit tasks_path
      click_link 'マイページ👶'
      visit new_user_registration_path
      expect(page).to have_content 'すでにログインしています。'
    end

    scenario '(8) the second user should be existing' do
      visit tasks_path

      click_link '❯❯❯ ログアウト'

      second_user_login #second user login method prepared at the  first.

      visit tasks_path
      click_link 'マイページ👶'
      visit new_user_registration_path
      expect(page).to have_content 'test_user2'
    end

  end
end
