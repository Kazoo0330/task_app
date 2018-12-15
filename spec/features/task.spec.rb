require 'rails_helper'

RSpec.feature "TASK management functionality", type: :feature do

  background do
    FactoryBot.create(:task)
  end

  scenario "task index test" do
    visit "/"

    expect(page).to have_content "task_title1"
  end

  scenario "create a new task" do

  end

  scenario "show specific task info" do

  end

end
