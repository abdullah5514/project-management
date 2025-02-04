# frozen_string_literal: true

# Create Admin and Regular Users
puts 'Creating Users...'

admin = User.create!(
  name: 'Admin User',
  email: 'admin@example.com',
  role: 'Admin',
  password: 'password',
  password_confirmation: 'password'
)

user1 = User.create!(
  name: 'John Doe',
  email: 'john.doe@example.com',
  role: 'User',
  password: 'password',
  password_confirmation: 'password'
)

user2 = User.create!(
  name: 'Jane Smith',
  email: 'jane.smith@example.com',
  role: 'User',
  password: 'password',
  password_confirmation: 'password'
)

puts "Created #{User.count} users."

# Create Projects with varying start dates and durations
puts 'Creating Projects...'

project1 = Project.create!(
  name: 'Website Redesign',
  start_date: Date.parse('2025-02-01'),
  duration: '2 weeks'
)

project2 = Project.create!(
  name: 'Mobile App Development',
  start_date: Date.parse('2025-01-15'),
  duration: '3 months'
)

project3 = Project.create!(
  name: 'Database Migration',
  start_date: Date.parse('2025-03-01'),
  duration: '1 month'
)

puts "Created #{Project.count} projects."

# Assign Projects to Users
puts 'Assigning Users to Projects...'

project1.users << admin
project1.users << user1

project2.users << admin
project2.users << user2

project3.users << user1

puts 'Assigned users to projects.'

# Create Tasks for each Project
puts 'Creating Tasks...'

# Tasks for Website Redesign
project1.tasks.create!(
  name: 'Homepage Design',
  description: 'Design the homepage layout and structure.',
  start_time: DateTime.parse('2025-02-02 09:00:00'),
  end_time: DateTime.parse('2025-02-02 11:00:00'),
  user: user1
)

project1.tasks.create!(
  name: 'Backend Setup',
  description: 'Setup the initial backend environment for the website.',
  start_time: DateTime.parse('2025-02-03 10:00:00'),
  end_time: DateTime.parse('2025-02-03 14:00:00'),
  user: user1
)

# Tasks for Mobile App Development
project2.tasks.create!(
  name: 'Mobile UI Design',
  description: 'Create the design of the mobile app.',
  start_time: DateTime.parse('2025-01-20 10:00:00'),
  end_time: DateTime.parse('2025-01-20 14:00:00'),
  user: user2
)

project2.tasks.create!(
  name: 'API Development',
  description: 'Develop the API for the mobile app.',
  start_time: DateTime.parse('2025-01-25 15:00:00'),
  end_time: DateTime.parse('2025-01-25 18:00:00'),
  user: user2
)

# Tasks for Database Migration
project3.tasks.create!(
  name: 'Database Schema Update',
  description: 'Update the database schema to support new features.',
  start_time: DateTime.parse('2025-03-02 08:00:00'),
  end_time: DateTime.parse('2025-03-02 12:00:00'),
  user: user1
)

puts "Created #{Task.count} tasks."

puts 'Seeding completed!'
