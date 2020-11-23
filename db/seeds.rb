# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)

ENV["api_private_key"]
ENV["api_public_key"]
payload = "grant_type=client_credentials&client_id="+ENV["api_public_key"]+"&client_secret="+ENV["api_private_key"]

token = RestClient.post("https://api.tcgplayer.com/token", payload  ,headers={"content-type": "application/x-www-form-urlencoded"})

token = JSON.parse(token)
@access_token = token['access_token']

# def all_cards
#     length = 0
#     response = RestClient.get 'https://api.tcgplayer.com/catalog/products?categoryId=1&productTypes=cards', {:Authorization => 'Bearer '+ @access_token}
#     length = JSON.parse(response)['totalItems']
#     offset = 0
#     json = []
#     while offset < length do
#         response = RestClient.get('https://api.tcgplayer.com/catalog/products?categoryId=1&getExtendedFields=true&productTypes=cards&offset='+offset.to_s+'&limit=100', {:Authorization => 'Bearer '+ @access_token}){ |response, request, result, &block|
#                         case response.code
#                         when 200
#                             json.push(JSON.parse(response)['results'])
#                         when 404
#                             puts offset, count
#                         else
#                           response.return!(request, result, &block)
#                         end }
#         offset += 100
#     end
#     puts "jason => ", json.flatten
#     return json.flatten
# end

# def check_rarity(values)
#     rarity = ""
#     values.each do |value|
#         if value['name'] === "Rarity"
#             if value['value'] == 'U'
#                 rarity = 'Uncommon'
#             elsif value['value'] == 'T'
#                 rarity = 'Token'
#             elsif value['value'] == 'S'
#                 rarity = 'Special'
#             elsif value['value'] == 'P'
#                 rarity = 'Promo'
#             elsif value['value'] == 'M'
#                 rarity = 'Mythic'
#             elsif value['value'] == 'L'
#                 rarity = 'Land'
#             elsif value['value'] == 'C'
#                 rarity = 'Common'
#             elsif value['value'] == 'R'
#                 rarity = 'Rare'
#             end
#         end
#     end
#     return rarity
# end

# def check_text(values)
#     text = ''
#     values.each do |value|
#         if value['name'] == "OracleText"
#             text = value['value']
#         end
#     end
#     return text
# end

# def check_sub_type(values)
#     sub_type = ''
#     values.each do |value|
#         if value['name'] == "SubType"
#             sub_type = value['value']
#         end
#     end
#     return sub_type
# end

# all_cards.sort_by{|card| card['id']}.each do |card|
#         if card && !MagicCard.all.exists?(product_id: card['productId'])
#             puts 'card => ', card
#         MagicCard.create(name: card["name"], img_url: card['imageUrl'], category_id: card['categoryId'], group_id: card['groupId'], product_id: card['productId'],rarity: check_rarity(card['extendedData']), sub_type: check_sub_type(card['extendedData']), text: check_text(card['extendedData']))
#         else
#             puts "card exist in database"
#         end
# end

# MagicCard.default_order.all.each do |c|
#     group_response = RestClient.get 'https://api.tcgplayer.com/catalog/groups/'+ c['group_id'].to_s, {:Authorization => 'Bearer '+ @access_token}
#     group_json = JSON.parse(group_response)['results'][0]
#     puts 'card id => ', c['id']
#     puts 'group id => ', c['group_id']
#       if c['group_name']== nil
#         c.update(
#             group_name: group_json['name']
#         )
#       end
#     puts 'group name within json => ', group_json['name']
#     puts 'group name after the card updated =>', c['group_name']
# end

# MagicCard.default_order.all.slice(35960, MagicCard.default_order.all.length).each do |c|
# # MagicCard.default_order.all.each do |c|
# # MagicCard.default_order.all.slice(50000, 10000).each do |c|
#     # puts 'card name => ' + c['name'] + ' product_id => ' + c['product_id'].to_s + ' id => ' + c['id'].to_s
#     price_response = RestClient.get'https://api.tcgplayer.com/pricing/product/' + c['product_id'].to_s, {:Authorization => 'Bearer '+ @access_token}

#     price_json = JSON.parse(price_response)['results']
#     puts 'price_json => ', price_json
#     puts 'card in database => ', c['product_id']
#     puts 'card id database => ', c['id']
#     price_json.map do |price_data|
#     puts 'subTypeName => ', price_data['subTypeName']
#         if price_data['subTypeName'] == 'Normal'
#             puts 'it should be normal price = >', price_data['lowPrice']
#             c.update(
#                 normal_low_price: price_data['lowPrice'],
#                 normal_mid_price: price_data['midPrice'],
#                 normal_high_price: price_data['highPrice'],
#                 normal_market_price: price_data['marketPrice']
#             )
#         elsif price_data['subTypeName'] == 'Foil'
#             puts 'it should be foil price = >', price_data['lowPrice']
#             c.update(
#                 foil_low_price: price_data['lowPrice'],
#                 foil_mid_price:price_data['midPrice'],
#                 foil_high_price: price_data['highPrice'],
#                 foil_market_price:price_data['marketPrice']
#             )
#         end
#     end
#     puts 'card updated' + ' card normal_low_price => ' + c['normal_low_price'].to_s
#     puts 'card updated' + ' card foil_low_price => ' + c['foil_low_price'].to_s
#     # puts 'foil => ', c['foil']
# end

# MagicCard.default_order.all.slice(25000, MagicCard.default_order.all.length).each do |c|
#     puts ' id => ' + c['id'].to_s
#     puts 'group id => ' + c['group_id'].to_s

#     icon_response  =  RestClient.get('https://tcgplayer-cdn.tcgplayer.com/set_icon/' + c['group_id'].to_s + '.jpg'){|response, request, result, block|
#         case response.code
#         when 200
#             c.update(
#             icon: 'https://tcgplayer-cdn.tcgplayer.com/set_icon/' + c['group_id'].to_s + '.jpg'
#         )
#         when 403
#             c.update(
#                 icon: ""
#             )
#         end
#     }
# end

# MagicCard.default_order.all.slice(5000, MagicCard.default_order.all.length).each do |card|
#     if !card['group_name']
#         card.destroy
#         puts card['id']
#         puts 'group name' + card['group_name'].to_s
#         puts card['name'] + 'is destroyed'
#     end
# end

MagicCard.default_order.all.slice(18953, 6050).each do |card|
    puts 'id => ' + card['id'].to_s
    puts 'product_id => ' + card['product_id'].to_s
    response_body = begin
        RestClient.get('https://api.scryfall.com/cards/tcgplayer/' + card['product_id'].to_s)
        rescue => e
        e.response.body
        end
    json_response = JSON.parse(response_body)
    # puts json_response
    if json_response['code'] != "not_found"
        puts "colors => "
        if json_response
            if json_response['colors']
                if json_response['colors'].length > 0
                puts json_response['colors']
                json_response = json_response['colors']
                elsif json_response['color_identity']
                    puts json_response['color_identity']
                   json_response = json_response['color_identity']
                end
            elsif json_response["card_faces"]
                puts json_response["card_faces"][0]['colors']
                json_response = json_response["card_faces"][0]["colors"]
            end
        end
        if json_response
            if json_response.length == 1
                if json_response.include?("W")
                    puts "White"
                    card.update(color: "White")
                elsif json_response.include?("U")
                    puts "Blue"
                    card.update(color: "Blue")
                elsif json_response.include?("B")
                    puts "Black"
                    card.update(color: "Black")
                elsif json_response.include?("R")
                    puts "Red"
                    card.update(color: "Red")
                elsif json_response.include?("G")
                    puts "Green"
                card.update(color: "Green")
                end
            elsif json_response.length > 1
                puts "Multicolor"
                card.update(color: "Multicolor")
            elsif json_response.empty?
                puts "Colorless"
                card.update(color: "Colorless")
            end
        end
    else
        puts "error"
        card.update(
            color: ""
        )
    end
end

puts "Seeded 🍇"