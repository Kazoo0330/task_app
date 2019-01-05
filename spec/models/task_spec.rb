require 'rails_helper'

RSpec.describe Task, type: :model do

  it 'is valid with completed insertion with title and content' do
    task = Task.new(
      title: 'みんなにエサやり🐕',
      content: '食べてくれるかな'
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
end
