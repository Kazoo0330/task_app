require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with an email" do
    user = User.new(
      name: "かずー",
      email: "test@example.com",
      password: "password"
    )
    expect(user).to be_valid
  end

  it "is invalid without an email" do
    user = User.new(
      name: "かずーMk-II",
      password: "password"
    )
    expect(user).to be_invalid
  end

  it "is invalid without an email Mk-II" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include('を入力してください')
  end

  it "is invalid without a name to create a new user" do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include('を入力してください')
  end
end
