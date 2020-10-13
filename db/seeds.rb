# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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
#         puts 'card => ', card
#         if card
#         MagicCard.create(name: card["name"], img_url: card['imageUrl'], category_id: card['categoryId'], group_id: card['groupId'], product_id: card['productId'],rarity: check_rarity(card['extendedData']), sub_type: check_sub_type(card['extendedData']), text: check_text(card['extendedData']))
#         else
#             puts "no more card"
#         end
# end

MagicCard.default_order.all.each do |c|
    group_response = RestClient.get 'https://api.tcgplayer.com/catalog/groups/'+ c['group_id'].to_s, {:Authorization => 'Bearer '+ @access_token}
    group_json = JSON.parse(group_response)['results'][0]
    puts 'card id => ', c['id']
    puts 'group id => ', c['group_id']
    c.update(
        group_name: group_json['name']
    )
    puts 'group name within json => ', group_json['name']
    puts 'group name after the card updated =>', c['group_name']
end

puts "Seeded 🍇"