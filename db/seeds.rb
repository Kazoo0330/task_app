5.times do |idx|
  n = idx + 1
  user = User.create(
    name: "user_#{n}",
    email: "email_#{n}@example.com",
    password: "#{n}password",
  )
  user.save!
end
