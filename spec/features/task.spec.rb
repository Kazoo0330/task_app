require 'rails_helper'

RSpec.feature "TASK management functionality", type: :feature do

  background do
    user = FactoryBot.create(:user)

    FactoryBot.create(:task, title: 'first task', content: 'first task content', expires_on: Time.zone.today + 1, status: Task::statuses['未着手🦖'])
    FactoryBot.create(:task, title: 'second task', content: 'second task content', expires_on: Time.zone.today + 5, status: Task::statuses['着手中🐕💨'])
    FactoryBot.create(:task, title: 'third task', content: 'third task content', expires_on: Time.zone.today + 3, status: Task::statuses['完了✅'])

    # FactoryBot.create(:second_task)
    # FactoryBot.create(:task3)
    # FactoryBot.create(:task4)
    # FactoryBot.create(:task5)
  end

  scenario "task index test" do
    visit "/"

    expect(page).to have_content "first task"
    expect(page).to have_content "second task"
    expect(page).to have_content "third task"
  end

  scenario "create a new task" do
  end

  scenario "show specific task info" do
  end

  scenario "testing that tasks are listed completely by ordering created_at" do
    visit tasks_path
    all('tr td')[5].click_link '詳細🔎'
    expect(page).to have_content 'third task'

  end

  scenario 'testing that tasks are able to be sorted by priority button' do
    visit tasks_path
    click_link '優先順位⬆️'
    all('tr td')[5].click_link '詳細🔎'
    expect(page).to have_content 'first task'
  end

  scenario 'testing that tasks are able to be sorted by priority button with the second task' do
    visit tasks_path
    click_link '優先順位⬆️'
    all('tr td')[21].click_link '詳細🔎'
    expect(page).to have_content 'second task'
  end

  scenario 'waiting tasks will only be shown with searching "waiting" tasks' do
    visit tasks_path
    select '未着手🦖', from: 'task_status'
    click_on '検索🐾'
    expect(page).to have_content 'first task'
    expect(page).to_not have_content 'second task'
    expect(page).to_not have_content 'third task'
  end

  scenario 'testing working tasks search' do
    visit tasks_path
    select '着手中🐕💨', from: 'task_status'
    click_on '検索🐾'
    expect(page).to have_content 'second task'
    expect(page).to_not have_content 'first task'
    expect(page).to_not have_content 'third task'
  end

  scenario 'testing completed tasks search' do
    visit tasks_path
    select '完了✅', from: 'task_status'
    click_on '検索🐾'
    expect(page).to have_content 'third task'
    expect(page).to_not have_content 'first task'
    expect(page).to_not have_content 'second task'
  end

  scenario 'testing search with nothing specified' do
    visit tasks_path
    select '', from: 'task_status'
    click_on '検索🐾'
    expect(page).to have_content 'first task'
    expect(page).to have_content 'third task'
    expect(page).to have_content 'second task'
  end

  scenario 'testing search for specific title' do
    visit tasks_path
    fill_in 'task_title', with: 'first'
    select '', from: 'task_status'
    click_on '検索🐾'
    expect(page).to have_content 'first task'
    expect(page).to_not have_content 'second task'
    expect(page).to_not have_content 'third task'
  end

  scenario 'testing content search for tasks' do
    visit tasks_path
    fill_in 'task_content', with: 'third task content'
    select '', from: 'task_status'
    click_on '検索🐾'
    expect(page).to have_content 'third task'
    expect(page).to_not have_content 'first task'
    expect(page).to_not have_content 'second task'
  end

  scenario 'searching second task by filling every single part' do
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

  scenario 'searching tasks by title and content' do
    visit tasks_path
    fill_in 'task_title', with: 'third task'
    fill_in 'task_content', with: 'third task content'
    select '', from: 'task_status'
    click_on '検索🐾'
    expect(page).to have_content 'third task'
    expect(page).to have_content 'third task content'
  end

end
