require 'json'
require 'open-uri'
require 'nokogiri'
require 'faker'

 User.destroy_all
 Category.destroy_all
 Product.destroy_all
 Alert.destroy_all
 Retailer.destroy_all
 Offer.destroy_all
 Price.destroy_all

#Configuration:
keyword = ['alienware']
number_of_product = 3

#*********************************************************

keyword.each do |word|
  count = 0
  number_of_product.times do
    user = User.new(
      email: Faker::Internet.email,
      password: 'azerty',
      first_name: Faker::Name.name,
      last_name: Faker::Name.name,
      mobile_phone: Faker::PhoneNumber.phone_number,
      )
    user.save!

    url_search = "https://search.ledenicheur.fr/classic?class=Search_Supersearch&method=search&market=fr&skip_login=1&modes=product,raw_sorted,raw&limit=12&q=#{word}"
    sleep(rand(0.2..1.2))
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
    sleep(rand(0.2..1.2))

  # Retailer name
    results.search('.v-centered').each do |row|
      retail_name = row.search('.drg-sidebar img').last&.values&.last
      next if retail_name.nil?
      existing_retailer = Retailer.find_by(name: retail_name)
      product = Product.last

      if existing_retailer
        offer = Offer.create!(retailer_id: existing_retailer.id, product: product)
        puts "offer #(#{offer.id})"
      else
        puts "* Detect a new retailer! (#{retail_name})"
        new_retailer = Retailer.create(name: retail_name, rating: 3, logo: row.children.children.search('img').attr('src').value)
        offer = Offer.create!(retailer_id: new_retailer.id, product: product)
        puts "offer #(#{offer.id})"
      end
      url_path = row.search('.js-ga-event-track').attr('href').value

      # Prices
      Price.create!(price: row.search('a.price').last.children.text.gsub(/[^\d]/, '').to_f/100, url: "https://ledenicheur.fr#{url_path}", offer: offer)

    end
      count += 1
      puts "#{word}# #{count} created"
      puts "====================="
  end
end
puts "FINISHED !"
puts "Hmm.. let's drink vodka!!!!!!!"
