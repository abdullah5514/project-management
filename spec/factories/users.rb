# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    name { "John Doe" }
    email { "johndoe@example.com" }
    password { "password" }
    password_confirmation { "password" }
    role { "user" }
  end
end
