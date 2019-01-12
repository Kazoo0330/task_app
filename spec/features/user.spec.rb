require 'rails_helper'

RSpec.feature "User functionality", type: :feature do

  background do
   user = FactoryBot.create(:user)
  end

  scenario "new session page check" do
    visit new_user_session_path

    expect(page).to have_content 'Remember me'
  end

  scenario "new session page check" do
    visit new_user_session_path

    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'

    expect(page).to have_content 'ログインしました。'
    expect(page).to have_content '現在ログイン中のユーザー'
  end

  scenario "create a new user from sign up" do
    visit root_path
    click_on 'サインアップ'
    # visit new_user_registration_path

    fill_in 'Name', with: 'test_kazoo'
    fill_in 'Email', with: 'first_user@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Sign up'

    expect(page).to have_content 'アカウント登録が完了しました。'
  end

  scenario "from logging in to create a new task" do
    visit root_path
    click_on 'ログイン'

    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'

    expect(page).to have_content 'タスク登録⭐️'

    click_on 'タスク登録⭐️'
    expect(page).to have_content 'タスク登録⭐️'

    fill_in 'task_title', with: 'task1'
    fill_in 'task_content', with: 'feed everyone'
    click_on 'タスク登録⭐️'

    expect(page).to have_content 'taskを作成しました✨'
  end
end
