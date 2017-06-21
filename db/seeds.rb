User.create! name: "tuanh", email: "tuanh@gmail.com", password: "123123",
  password_confirmation: "123123", is_admin: 1

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create! name: name, email: email, password: password,
    password_confirmation: password
end
