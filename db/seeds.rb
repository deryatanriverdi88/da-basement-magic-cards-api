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

def all_cards
    length = 0
    response = RestClient.get 'https://api.tcgplayer.com/catalog/products?categoryId=1&productTypes=cards', {:Authorization => 'Bearer '+ @access_token}
    length = JSON.parse(response)['totalItems']
    offset = 0
    json = []
    while offset < length do
        response = RestClient.get('https://api.tcgplayer.com/catalog/products?categoryId=1&getExtendedFields=true&productTypes=cards&offset='+offset.to_s+'&limit=100', {:Authorization => 'Bearer '+ @access_token}){ |response, request, result, &block|
                        case response.code
                        when 200
                            json.push(JSON.parse(response)['results'])
                        when 404
                            puts offset, count
                        else
                          response.return!(request, result, &block)
                        end }
        offset += 100
    end
    return json.flatten
end