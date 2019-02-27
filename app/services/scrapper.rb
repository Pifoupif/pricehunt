# require 'json'
# require 'open-uri'
# require 'nokogiri'
# require 'pry'

# puts "Please enter a keyword"
# keyword = gets.chomp
# url_search = "https://search.ledenicheur.fr/classic?class=Search_Supersearch&method=search&market=fr&skip_login=1&modes=product,raw_sorted,raw&limit=12&q=#{keyword}"
# search = open(url_search).read
# search_result = JSON.parse(search)


# count = 0
# while count < 1
#     #product = Product.new(
# puts "#{search_result['message']['product']['items'][count]['name']}"
# puts "#{search_result['message']['product']['items'][count]['price']['regular']}"
#     #puts "product description: #{count + 1} - #{search_result['message']['product']['items'][count]['category']['name']}"
# url_vers_show = "#{search_result['message']['product']['items'][count]['url']}"

# photo = Nokogiri::HTML(open(url_vers_show))
# photo.css('a.img140 img').each do |link|
# p link.values[0].strip
# end

# retailer = Nokogiri::HTML(open(url_vers_show))
# retailer.search('.drg-sidebar img').each do |link|
# p link.values.last
# end

# path = Nokogiri::HTML(open(url_vers_show))
# path.search('.v-centered').each do |link|
# p link.values.last
# binding.pry
# end

# retailer_price = Nokogiri::HTML(open(url_vers_show))
# retailer_price.css('a.price').each do |link|
# p link.content.split(',').join('.').to_f
# end
#     # )
# count += 1
# sleep(rand(2..4))
# end
#     # puts "choose the number of the model you want?"
#      # model = gets.chomp
#      # model_id = "#{search_result["message"]["product"]["items"][model.to_i-1]["id"]}"

#      # url_product = "https://ledenicheur.fr/product.php?p=#{model_id}"
#      # doc = Nokogiri::HTML(open(url_product))

#      # list = []
#      # puts "### Search for nodes by css"
#      # doc.css('a.price').each do |link|
#      #   puts link.content
#      # end
