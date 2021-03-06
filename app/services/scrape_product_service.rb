require 'json'
require 'open-uri'

class ScrapeProductService
  def initialize(denich_id)
    @denich_id = denich_id
  end

  def call
    url_search = "https://search.ledenicheur.fr/classic?class=Search_Supersearch&method=search&market=fr&skip_login=1&modes=product,raw_sorted,raw&limit=12&q=#{@denich_id}"
    search = open(url_search).read
    search_result = JSON.parse(search)
    url_vers_show = search_result['message']['product']['items'][0]['url']

    category = Category.where(
      name: search_result['message']['product']['items'][0]['category']['name']
    ).first_or_create!

    #***************************************************************************

    results = Nokogiri::HTML(open(url_vers_show))
    thumb_s = results.css('a.img140 img').last.attribute("src").value
    thumb = thumb_s.gsub!('140', '280')

    product = Product.where(
      photo: thumb,
      name: search_result['message']['product']['items'][0]['name'],
      description: search_result['message']['product']['items'][0]['price']['regular'],
      denich_id: search_result['message']['product']['items'][0]['id'],
      category_id: category.id
    )

    product.first_or_create!

    #***************************************************************************

    # Retailer name
    results.search('.v-centered').each do |row|
      retail_name = row.search('.drg-sidebar img').last&.values&.last
      next if retail_name.nil?
      existing_retailer = Retailer.find_by(name: retail_name)
      product = Product.find_by(denich_id: @denich_id)

      if existing_retailer
        offer = Offer.where(retailer: existing_retailer, product: product).first_or_create!
        puts "offer #(#{offer.id})"
      else
        puts "* Detect a new retailer! (#{retail_name})"
        new_retailer = Retailer.create(name: retail_name, rating: rand(3..5), logo: row.children.children.search('img').attr('src').value)
        offer = Offer.create!(retailer: new_retailer, product: product)
        puts "offer #(#{offer.id})"
      end
      url_path = row.search('.js-ga-event-track').attr('href').value

      # Prices
      Price.create!(price: row.search('a.price').last.children.text.gsub(/[^\d]/, '').to_f/100, url: "https://ledenicheur.fr#{url_path}", offer: offer)
    end

    return product
  end
end
