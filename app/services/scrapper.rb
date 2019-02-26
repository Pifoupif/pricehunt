 require 'json'
 require 'open-uri'
 require 'nokogiri'

# class ScrappeService

#   def initialize(scrappe)
#     @scrappe = scrappe
#   end

#   def call(keyword)
#   puts "Please enter a keyword"
    keyword = gets.chomp
    url_search = "https://search.ledenicheur.fr/classic?class=Search_Supersearch&method=search&market=fr&skip_login=1&modes=product,raw_sorted,raw&limit=12&q=#{keyword}"
    search = open(url_search).read
    search_result = JSON.parse(search)

    count = 0
    while count < 10
      puts "#{count + 1} - #{search_result['message']['product']['items'][count]['name']}"
      count += 1
    end

    puts "choose the number of the model you want?"
    model = gets.chomp
    model_id = "#{search_result["message"]["product"]["items"][model.to_i]["id"]}"

    url_product = "https://ledenicheur.fr/product.php?p=#{model_id}"
    html_file = open(url_product).read
    html_doc = Nokogiri::HTML(html_file)

    list = []
     html_doc.search('.drg-sidebar img').each do |element|
     list << element.values#.text.strip.sub('Article réservé à nos abonnés','')
    end

    count_offers = 1
    while count_offers < list.size
      puts "#{count_offers} - #{list[count_offers].last}"
      count_offers += 1
    end
  #end
#end
