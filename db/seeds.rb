# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts '***** Seeding Data *****'
puts '-> Creating default seed user'

User.first_or_create!(
  email: 'default_user@example.com',
  password: 'default_password'
)

puts '  -> default seed user created'

puts '-> Creating default dummy task'

Task.create!(
  description: 'Some dummy description here!',
  user: User.first,
  start: Time.current,
  end: Time.current + 1.day
)

puts '  -> dummy task created'
