# Create a main sample user.
User.create!(name:  "Gabriel Boucher",
  email: "gboucher93@gmail.com",
  password:              "test12345",
  password_confirmation: "test12345",
  admin: true)

# Generate a bunch of additional users.
99.times do |n|
name  = Faker::Name.name
email = "example-#{n+1}@railstutorial.org"
password = "password"
User.create!(name:  name,
    email: email,
    password:              password,
    password_confirmation: password,
    admin: false)
end