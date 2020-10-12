class MagicCardsController < ApplicationController
    def index
        magic_cards = MagicCard.all
        render json:magic_cards
    end
end
