require 'rails_helper'

RSpec.describe Task, type: :model do

    user = FactoryBot.create(:user)

  it 'is valid with completed insertion with title and content' do
    task = Task.new(
      title: 'みんなにエサやり🐕',
      content: '食べてくれるかな',
      user: user
    )
    expect(task).to be_valid
  end

  it 'is invalid without filling title' do
    task = Task.new(
      content: '食べてくれるかな'
    )
    expect(task).to be_invalid
  end

  it 'is invalid without filling content' do
    task = Task.new(
      title: 'みんなにエサやり😸'
    )
    expect(task).to be_invalid
  end

  it 'is invalid without any filling' do
    task = Task.new(
    )
    expect(task).to be_invalid
  end

  it 'is invalid with 0 character with title and content' do
    task = Task.new(
    title: '',
    content: ''
    )
    expect(task).to be_invalid
  end

  it 'is invalid with that the character amount exceeds the validation limit' do
    title_str = '🐕' * 150
    task = Task.new(
    title: "#{title_str}",
    content: '喜んでくれるかな'
    )
    expect(task).to be_invalid
  end

  it 'is invalid with that the character amount exceeds the validation limit' do
    content_txt = '🐕🐕' * 251
    task = Task.new(
    title: 'みんなにエサやり🐕',
    content: "#{content_txt}"
    )
    expect(task).to be_invalid
  end

  describe 'search functionality test' do
    before do
      FactoryBot.create(
        :task,
          title: 'みんなでおさんぽ🐕',
          content: 'どこいこうかな',
          status: Task::statuses['未着手🦖'],
          user: user
      )
      FactoryBot.create(
        :task,
          title: 'みんなにエサやり🐕',
          content: 'ぜんぶたべるかな',
          status: Task::statuses['着手中🐕💨'],
          user: user
      )
      FactoryBot.create(
        :task,
          title: 'みんなであそぶ⚽️',
          content: 'こうえん行こう',
          status: Task::statuses['完了✅'],
          user: user
      )
    end

    it 'is valid with title search' do
      expect(Task.search_with_title('みんな').count).to eq 3
    end
  end
end
