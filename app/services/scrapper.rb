 require 'json'
 require 'open-uri'
 require 'nokogiri'

# class ScrappeService

#   def initialize(scrappe)
#     @scrappe = scrappe
#   end

#   def call(keyword)
#*************************************

     puts "Please enter a keyword"
     keyword = gets.chomp
     url_search = "https://search.ledenicheur.fr/classic?class=Search_Supersearch&method=search&market=fr&skip_login=1&modes=product,raw_sorted,raw&limit=12&q=#{keyword}"
     search = open(url_search).read
     search_result = JSON.parse(search)

    count = 0
    while count < 10
      puts "product name: #{count + 1} - #{search_result['message']['product']['items'][count]['name']}"
      puts "product price: #{count + 1} - #{search_result['message']['product']['items'][count]['price']['regular']}"
      puts "product description: #{count + 1} - #{search_result['message']['product']['items'][count]['category']['name']}"
      puts "product show url: #{count + 1} - #{search_result['message']['product']['items'][count]['url']}"
      count += 1
    end

    puts "choose the number of the model you want?"

#*************************************
    model = gets.chomp
    model_id = "#{search_result["message"]["product"]["items"][model.to_i-1]["id"]}"

    url_product = "https://ledenicheur.fr/product.php?p=#{model_id}"
    doc = Nokogiri::HTML(open(url_product))

    list = []
      puts "### Search for nodes by css"
      doc.css('a.price').each do |link|
      puts link.content

    end

    count_offers = 1
    while count_offers < list.size
      #puts "#{count_offers} - #{list[count_offers].last}"
      puts "#{count_offers} - #{list}"
      count_offers += 1
    end


  #end
#end
