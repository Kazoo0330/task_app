require 'rails_helper'

RSpec.feature "TASK management functionality", type: :feature do

  background do
    user = FactoryBot.create(:user)

    FactoryBot.create(:task, title: 'first task', content: 'first task content')
    FactoryBot.create(:task, title: 'second task', content: 'second task content')
    FactoryBot.create(:task, title: 'third task', content: 'third task content')

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
    all('tr td')[3].click_link '詳細🔎'
    expect(page).to have_content 'third task'

  end

end
