require 'json'
require 'open-uri'
require 'nokogiri'
require 'faker'
require 'pry'

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
    email: "#{Faker::Name.name}@toto.com",
    password: 'azerty',
    first_name: Faker::Name.name,
    last_name: Faker::Name.name,
    mobile_phone: Faker::PhoneNumber.phone_number,
    )
  user.save!

  keyword = "stan"
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

#***************************************************************************

  results = Nokogiri::HTML(open(url_vers_show))

# Retailer name
  results.search('.v-centered').each do |row|
    retail_name = row.search('.drg-sidebar img').last&.values&.last
    next if retail_name.nil?

    existing_retailer = Retailer.find_by(name: retail_name)
    product = Product.last

    if existing_retailer
      offer = Offer.create!(retailer_id: existing_retailer.id, product: product)
    else
      new_retailer = Retailer.create(name: retail_name)
      offer = Offer.create!(retailer_id: new_retailer.id, product: product)
    end
    url_path = row.search('.js-ga-event-track').attr('href').value

  # Prices
    results.css('a.price').each do |link|
      Price.create!(price: link.content.split(',').join('.').to_f, url: url_path, offer: offer)
    end

    count += 1
    puts "#{keyword}#{count} created"
  end

#**********************************************************



end
