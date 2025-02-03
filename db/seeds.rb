# db/seeds.rb
admin = User.create!(name: 'Admin User', email: 'admin@example.com', role: 'Admin')
user = User.create!(name: 'Regular User', email: 'user@example.com', role: 'User')

projects = [
  { name: 'Website Redesign', start_date: Date.today, duration: '2 weeks' },
  { name: 'Mobile App Development', start_date: Date.today - 1.week, duration: '3 months' }
]

projects.each do |project|
  Project.create!(project).tasks.create!(
    name: 'Initial Setup',
    start_time: Time.current,
    end_time: Time.current + 2.hours,
    user: user
  )
end