Rails.application.routes.draw do
  resources :pins
  resources :charges

  devise_for :users
  root "pins#index"
  get "about" => "pages#about" #creates about_path
  get "contact" => "pages#contact" #creates contact_path
  get "auction" => "pages#auction" #creates auction_path
  get "terms" => "pages#terms" #creates terms_path
  post 'send_mail', to: 'contact#send_mail'
  get 'contact', to: 'contact#show'

  scope 'pins', controller: :pins do
    scope '/:id' do
      post 'bid', to: :bid
    end
  end

  scope 'admin', controller: :admin do
    scope 'pins' do
      get '/:pin_id', to: :pin
    end
  end
end
