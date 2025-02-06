# spec/factories/tasks.rb
FactoryBot.define do
  factory :task do
    name { "Sample Task" }
    description { "Task description goes here." }
    start_time { DateTime.now }
    end_time { DateTime.now + 2.hours }
    project
    user
  end
end
