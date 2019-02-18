require 'rails_helper'

RSpec.feature "TASK management functionality", type: :feature do

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

  def create_labels
    label = FactoryBot.create(:label)
    label2 = FactoryBot.create(:second_label)
    label3 = FactoryBot.create(:third_label)
  end

 background do

    user = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user, name: 'test_user2', email: 'test2@example.com', password: 'password')


    FactoryBot.create(:task, title: 'first task', content: 'first task content', expires_on: Time.zone.today + 1, status: Task::statuses['未着手🦖'], priority: Task::priorities['あとでいいや🙈'], user: user)
    FactoryBot.create(:task, title: 'second task', content: 'second task content', expires_on: Time.zone.today + 5, status: Task::statuses['着手中🐕💨'], priority: Task::priorities['やりたい🙉'], user: user)
    FactoryBot.create(:task, title: 'third task', content: 'third task content', expires_on: Time.zone.today + 6, status: Task::statuses['完了✅'], priority: Task::priorities['今すぐやらなきゃ🙊'], user: user)
    FactoryBot.create(:task, title: 'fourth task', content: 'fourth task content', expires_on: Time.zone.today + 7, status: Task::statuses['完了✅'], priority: Task::priorities['今すぐやらなきゃ🙊'], user: user)
    FactoryBot.create(:task, title: 'fifth task', content: 'fifth task content', expires_on: Time.zone.today + 8, status: Task::statuses['完了✅'], priority: Task::priorities['今すぐやらなきゃ🙊'], user: user)
    FactoryBot.create(:task, title: 'sixth task', content: 'sixth task content', expires_on: Time.zone.today + 9, status: Task::statuses['完了✅'], priority: Task::priorities['今すぐやらなきゃ🙊'], user: user)
    FactoryBot.create(:task, title: 'second user task', content: 'second user task content', expires_on: Time.zone.today + 9, status: Task::statuses['完了✅'], priority: Task::priorities['今すぐやらなきゃ🙊'], user: user2)

    login

  end

  feature 'throughout feature spec test requires user to be logged in' do

    scenario "(1)task index test" do
      visit "/"
      expect(page).to have_content "fourth task"
      expect(page).to have_content "fifth task"
      expect(page).to have_content "sixth task"
    end

    scenario "(2)create a new task" do
    end

    scenario "(3)show specific task info" do
    end

    scenario "(4)testing that tasks are listed completely by ordering created_at" do

      visit tasks_path
      all('tr td')[7].click_link '詳細🔎'
      expect(page).to have_content 'sixth task'

    end

    scenario '(5)testing that tasks are able to be sorted by priority button' do

      visit tasks_path
      click_link '優先順位⬆️'
      all('tr td')[7].click_link '詳細🔎'
      expect(page).to have_content 'first task'
    end

    scenario '(6)testing that tasks are able to be sorted by priority button with the second task' do

      visit tasks_path
      click_link '優先順位⬆️'
      all('tr td')[27].click_link '詳細🔎'
      expect(page).to have_content 'third task'
    end

    scenario '(7)waiting tasks will only be shown with searching "waiting" tasks' do

      visit tasks_path
      select '未着手🦖', from: 'task_status'
      click_on '検索🐾'
      expect(page).to have_content 'first task'
      expect(page).to_not have_content 'second task'
      expect(page).to_not have_content 'third task'
    end

    scenario '(8)testing working tasks search' do

      visit tasks_path
      select '着手中🐕💨', from: 'task_status'
      click_on '検索🐾'
      expect(page).to have_content 'second task'
      expect(page).to_not have_content 'first task'
      expect(page).to_not have_content 'third task'
    end

    scenario '(9)testing completed tasks search' do

      visit tasks_path
      select '完了✅', from: 'task_status'
      click_on '検索🐾'
      expect(page).to have_content 'third task'
      expect(page).to_not have_content 'first task'
      expect(page).to_not have_content 'second task'
    end

    scenario '(10)testing search with nothing specified' do

      visit tasks_path
      select '', from: 'task_status'
      click_on '検索🐾'
      expect(page).to have_content 'sixth task'
      expect(page).to have_content 'fifth task'
      expect(page).to have_content 'fourth task'
      expect(page).to have_content 'third task'
      expect(page).to have_content 'second task'
      expect(page).to_not have_content 'first task'
    end

    scenario '(11)testing search for specific title' do

      visit tasks_path
      fill_in 'task_title', with: 'first'
      select '', from: 'task_status'
      click_on '検索🐾'
      expect(page).to have_content 'first task'
      expect(page).to_not have_content 'second task'
      expect(page).to_not have_content 'third task'
    end

    scenario '(12)testing content search for tasks' do

      visit tasks_path
      fill_in 'task_content', with: 'third task content'
      select '', from: 'task_status'
      click_on '検索🐾'
      expect(page).to have_content 'third task'
      expect(page).to_not have_content 'first task'
      expect(page).to_not have_content 'second task'
    end

    scenario '(13)searching second task by filling every single part' do

      visit tasks_path
      fill_in 'task_title', with: 'second task'
      fill_in 'task_content', with: 'second task content'
      select '着手中🐕💨', from: 'task_status'
      click_on '検索🐾'
      expect(page).to have_content 'second task'
      expect(page).to have_content 'second task content'
      expect(page).to_not have_content 'first task'
      expect(page).to_not have_content 'third task'
    end

    scenario '(14)searching tasks by title and content' do

      visit tasks_path
      fill_in 'task_title', with: 'third task'
      fill_in 'task_content', with: 'third task content'
      select '', from: 'task_status'
      click_on '検索🐾'
      expect(page).to have_content 'third task'
      expect(page).to have_content 'third task content'
    end

    scenario '(15)ensure that the task with the highest priority can be found at the top of tasks.' do

      visit tasks_path
      all('tr td')[7].click_link '詳細🔎'
      expect(page).to have_content '今すぐやらなきゃ🙊'
      expect(page).to_not have_content 'あとでいいや🙈'
      expect(page).to_not have_content 'やりたい🙉'
    end

    scenario '(16) the pagination should enable user to move b/w 1st page and 2nd page' do
      visit tasks_path
      click_link '2'
      expect(page).to have_content 'first task'
      click_link '1'
      expect(page).to have_content 'sixth task'
      expect(page).to have_content 'fifth task'
      expect(page).to have_content 'fourth task'
      expect(page).to have_content 'third task'
      expect(page).to have_content 'second task'
      expect(page).to_not have_content 'first task'
    end

    scenario '(17) users should be able to move the pge with "Next" and "Last" links' do
      visit tasks_path
      click_link '次'
      expect(page).to have_content 'first task'
      click_link '最初'
      expect(page).to have_content 'sixth task'
      expect(page).to have_content 'fifth task'
      expect(page).to have_content 'fourth task'
      expect(page).to have_content 'third task'
      expect(page).to have_content 'second task'
      expect(page).to_not have_content 'first task'
      click_link '2'
      expect(page).to have_content 'first task'
      click_link '前'
      expect(page).to have_content 'second task'
      expect(page).to_not have_content 'first task'
    end

    scenario '(18) user name should be shown in the show action view' do
      visit tasks_path
      all('tr td')[7].click_link '詳細🔎'
      expect(page).to have_content 'test_user'
    end

    scenario '(19) ensure that the user show action functionality properly working' do
      visit tasks_path
      click_link 'マイページ👶'
      expect(page).to have_content 'メールアドレス📧'
      expect(page).to have_content 'test@example.com'
    end

    scenario '(20) user functionality should be able to allow current_user to logout' do
      visit tasks_path
      click_link 'マイページ👶'
      expect(page).to have_content 'test@example.com'

      click_link '❯❯❯ ログアウト'
      expect(page).to have_content 'ログアウトしました。'
    end

    scenario '(21) logged in user should be unable to visit the user registration page' do
      visit tasks_path
      click_link 'マイページ👶'
      visit new_user_registration_path
      expect(page).to have_content 'すでにログインしています。'
    end

    scenario '(22) the second user should be existing' do
      visit tasks_path

      click_link '❯❯❯ ログアウト'

      second_user_login #second user login method prepared at the  first.

      visit tasks_path
      click_link 'マイページ👶'
      visit new_user_registration_path
      expect(page).to have_content 'test_user2'
    end

    scenario '(23) creating a new task with labels' do
      create_labels
      visit new_task_path

      expect(page).to have_content 'おつかい'
      expect(page).to have_content 'おるすばん'
      expect(page).to have_content 'おてつだい'
    end

    scenario '(24) ensure that search_with_label works properly' do
      create_labels
      visit tasks_path

      # save_and_open_page
      all('tr td')[8].click_link '編集✏️'
      binding.pry
      expect(page).to have_content 'おつかい'
      expect(page).to have_content 'おるすばん'
      expect(page).to have_content 'おてつだい'

      check 'task_label_ids_6'
      # save_and_open_page
      find(".actions").click
      click_link 'もどる↩️'
      expect(page).to have_content 'sixth task'

      select 'おてつだい', from: 'task_label_id'
      click_on '検索🐾'
      # expect(page).to have_content 'sixth task'
    end

  end
end
