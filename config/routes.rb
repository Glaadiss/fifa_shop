Rails.application.routes.draw do

  get 'configurations/edit'

    root 'accounts#new'
    resources :configurations, only: [:edit, :update]
    resources :userss
    resources :accounts do
      put '/correction' => 'accounts#correction'
    end
    post '/get_email' => 'accounts#get_email', default: 'json'
    get '/emails' => 'configurations#emails'
    delete '/emails' => 'configurations#delete_email'
    post '/create_email' => 'configurations#create_emails'
    post 'paid' => 'accounts#paid'
    get '/contact' => 'accounts#contact'
    get '/regulations' => 'accounts#regulations'
    devise_for :users
    get '*path', to: redirect("/#{I18n.default_locale}/%path")
    get '', to: redirect("/#{I18n.default_locale}")

end
