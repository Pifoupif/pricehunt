require 'json'
require 'open-uri'
require 'nokogiri'

class DailyOffersUpdateService
  def initialize(alert)
    @alert = alert
  end

  def call(alert)
    count = 0
    word = alert.product.denich_id
    url_search = "https://search.ledenicheur.fr/classic?class=Search_Supersearch&method=search&market=fr&skip_login=1&modes=product,raw_sorted,raw&limit=12&q=#{word}"
    # sleep(rand(0.1..0.2))
    search = open(url_search).read
    search_result = JSON.parse(search)
    url_vers_show = "#{search_result['message']['product']['items'][count]['url']}"

    results = Nokogiri::HTML(open(url_vers_show))

    product = alert.product

    results.search('.v-centered').each do |row|
      retail_name = row.search('.drg-sidebar img').last&.values&.last
      next if retail_name.nil?

      price = row.search('a.price').last.children.text.gsub(/[^\d]/, '').to_f / 100

      existing_retailer = Retailer.find_by(name: retail_name)

      offer = if existing_retailer
                Offer.find_or_create_by product: product, retailer: existing_retailer
              else
                puts "* Detect a new retailer! (#{retail_name})"
                new_retailer = Retailer.create(name: retail_name, rating: rand(1..5), logo: row.children.children.search('img').attr('src').value)
                Offer.create!(retailer: new_retailer, product: product)
              end

      puts "offer #(#{offer.id})"

      url_path = row.search('.js-ga-event-track').attr('href').value
      create_offer_price(offer, price, url_path)
    end
    count += 1
    puts "#{word}# #{count} created"
    puts "====================="

    update_alert_with_lowest_price(alert, product)
  end

  def create_offer_price(offer, price, url_path)
    Price.create!(
      price: price,
      url: "https://ledenicheur.fr#{url_path}",
      offer: offer
    )
  end

  def update_alert_with_lowest_price(alert, product)
    today_last_prices = []
    product.offers.each do |offer|
      next if offer_invalid?(offer)

      today_last_prices << offer.prices.last
    end

    today_lowest_price = today_last_prices&.min_by { |price| price.price }

    add_lowest_price(alert, today_lowest_price)
  end

  def offer_invalid?(offer)
    # si le dernier prix n'a pas été créé aujourd'hui, ça veut dire que l'offre n'est plus valable
    offer.prices.last.created_at.to_date < Date.current
  end

  def add_lowest_price(alert, today_lowest_price)
    if today_lowest_price
      alert.update offer_today: true
      LowestPrice.create alert: alert, price: today_lowest_price
    else
      alert.update offer_today: false
    end
  end
end
