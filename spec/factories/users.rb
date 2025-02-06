# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    name { "John Doe" }
    email { Faker::Internet.unique.email }
    password { 'password' }
    password_confirmation { "password" }
    role { "user" }
  end
end
