# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'faker'

"Destroying existing db"
Alert.destroy_all
User.destroy_all
Price.destroy_all
Offer.destroy_all
Product.destroy_all
Category.destroy_all
Retailer.destroy_all

"Creating new db"
10.times do
  user = User.new(
    email: Faker::Internet.email,
    password: 'azerty',
    first_name: Faker::Name.name,
    last_name: Faker::Name.name,
    mobile_phone: Faker::PhoneNumber.phone_number,
    )
  user.save!

  category = Category.new(
    name: Faker::Commerce.department
    )
  category.save!

  product = Product.new(
    name: Faker::Commerce.product_name,
    description: 'the description of the product',
    category_id: category.id,
    photo: "https://picsum.photos/200/300/?random",
    )
  product.save!

  alert = Alert.new(
    user_id: user.id,
    product_id: product.id,
    target_price: Faker::Number.decimal(1),
    )
  alert.save!

  retailer = Retailer.new(
    name: Faker::Company.name,
    logo: "https://picsum.photos/30/30/?random",
    rating: '4',
    )
  retailer.save!

  offer = Offer.new(
    product_id: product.id,
    retailer_id: retailer.id,
    )
  offer.save!

  price = Price.new(
    price: rand(40..300),
    url: '###',
    offer_id: offer.id,
    )
  price.save!

end


