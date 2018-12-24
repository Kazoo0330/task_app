require 'rails_helper'

RSpec.feature "TASK management functionality", type: :feature do

  background do
    FactoryBot.create(:task)
    # FactoryBot.create(:second_task)
    # FactoryBot.create(:task3)
    # FactoryBot.create(:task4)
    # FactoryBot.create(:task5)
  end

  scenario "task index test" do
    visit "/"

    expect(page).to have_content "task_title1"
    # expect(page).to have_content "task_title2"
    # expect(page).to have_content "task_title3"
    # expect(page).to have_content "task_title4"
    # expect(page).to have_content "task_title5"
  end

  scenario "create a new task" do

  end

  scenario "show specific task info" do

  end

end
