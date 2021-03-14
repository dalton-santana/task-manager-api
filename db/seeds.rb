# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

User.create!(
    id: 1, 
    name: Faker::Name.name,
    email: "teste@teste.com",
    password: "password", 
    password_confirmation: "password",
)
User.create!(
    id: 2, 
    name: Faker::Name.name,
    email: "teste2@teste.com",
    password: "password", 
    password_confirmation: "password",
)


(1..20).each do |id|
    Task.create!(
        id: id,
        user_id: rand(1..2), 
        title: Faker::Food.dish, 
        status: Faker::Boolean.boolean,
        is_visible: Faker::Boolean.boolean,
        description: Faker::Food.ingredient 
    )
end