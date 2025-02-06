# spec/factories/projects.rb
FactoryBot.define do
  factory :project do
    name { "Test Project" }
    start_date { Date.today }
    duration { "5 days" }
  end
end
