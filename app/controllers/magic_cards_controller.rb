class MagicCardsController < ApplicationController
    def index
        magic_cards = MagicCard.all
        render json:magic_cards.default_order
    end

    def show
        magic_card = MagicCard.find(params[:id])
        render json: magic_card
    end

    def last_ten
        render json:cards = MagicCard.all.alphabetical.last(1)
    end

    def token
        ENV["api_private_key"]
        ENV["api_public_key"]
        payload = "grant_type=client_credentials&client_id="+ENV["api_public_key"]+"&client_secret="+ENV["api_private_key"]

        token = RestClient.post("https://api.tcgplayer.com/token", payload  ,headers={"content-type": "application/x-www-form-urlencoded"})

        token = JSON.parse(token)
        render  json: token
    end

    def card
        magic_card = MagicCard.where(
            MagicCard.arel_table[:name]
               .lower
               .eq(params[:name].downcase)
        )

        render json: magic_card
    end

end