require 'rails_helper'

RSpec.describe User, type: :model do
  it "is invalid with an email and account" do
    user = User.new(
      name: "test_user",
      email: "test@example.com",
      password: "password"
    )
    expect(user).to be_valid
  end
end
