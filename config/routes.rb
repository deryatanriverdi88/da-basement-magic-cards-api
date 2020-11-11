Rails.application.routes.draw do
  resources :magic_cards

  get '/last_ten', to: 'magic_cards#last_ten', as: 'last_ten'
  get '/token', to: 'magic_cards#token', as: 'token'
  get '/card', to: 'magic_cards#card', as: 'card'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
