# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

 User.destroy_all
 Category.destroy_all
 Product.destroy_all
 Alert.destroy_all
 Retailer.destroy_all
 Offer.destroy_all
 Price.destroy_all

count = 0
3.times do
  sleep(rand(2..4))
  user = User.new(
    email: Faker::Internet.email,
    password: 'azerty',
    first_name: Faker::Name.name,
    last_name: Faker::Name.name,
    mobile_phone: Faker::PhoneNumber.phone_number,
    )
  user.save!

count += 1
require 'json'
require 'open-uri'
require 'nokogiri'

keyword = "iphone"
url_search = "https://search.ledenicheur.fr/classic?class=Search_Supersearch&method=search&market=fr&skip_login=1&modes=product,raw_sorted,raw&limit=12&q=#{keyword}"
search = open(url_search).read
search_result = JSON.parse(search)
url_vers_show = "#{search_result['message']['product']['items'][count]['url']}"

  category = Category.new(
    name: "#{search_result['message']['product']['items'][count]['category']['name']}"
    )
  category.save!


  photo = Nokogiri::HTML(open(url_vers_show))
  thumb = []
  photo.css('a.img140 img').each do |link|
    thumb = link.values[0].strip
  end

    product = Product.new(
    photo: "#{thumb}",
    name: "#{search_result['message']['product']['items'][count]['name']}",
    description: "#{search_result['message']['product']['items'][count]['price']['regular']}",
    category_id: category.id,
    )

  product.save!

  retailer = Retailer.new(
    name: Faker::Company.name,
    logo: '##',
    rating: '4',
    )
  retailer.save!

  puts "#{keyword}#{count} created"
#**********************************************************

  alert = Alert.new(
    user_id: user.id,
    product_id: product.id,
    target_price: Faker::Number.decimal(1),
    )
  alert.save!

  offer = Offer.new(
    product_id: product.id,
    retailer_id: retailer.id,
    )
  offer.save!

  price = Price.new(
    price: "#{search_result['message']['product']['items'][count]['price']['regular']}",
    url: url_vers_show,
    offer_id: offer.id,
    )
  price.save!

end
