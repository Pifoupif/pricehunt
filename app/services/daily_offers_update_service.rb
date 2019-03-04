require 'pry'
require 'json'
require 'open-uri'
require 'nokogiri'

class DailyOffersUpdateService

  def initialize(alert)
    @alert = alert
  end
  def call(alert)
  count = 0
 # binding.pry
    word = alert.product.denich_id
    url_search = "https://search.ledenicheur.fr/classic?class=Search_Supersearch&method=search&market=fr&skip_login=1&modes=product,raw_sorted,raw&limit=12&q=#{word}"
    # sleep(rand(0.1..0.2))
    search = open(url_search).read
    search_result = JSON.parse(search)
    url_vers_show = "#{search_result['message']['product']['items'][count]['url']}"

    results = Nokogiri::HTML(open(url_vers_show))

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
        new_retailer = Retailer.create(name: retail_name, rating: rand(1..5), logo: row.children.children.search('img').attr('src').value)
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
