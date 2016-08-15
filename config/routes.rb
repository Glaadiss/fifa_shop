Rails.application.routes.draw do

    root 'home#index'
    resources :users
    resources :accounts do
      put '/correction' => 'accounts#correction'
    end
    devise_for :users
    get '*path', to: redirect("/#{I18n.default_locale}/%path")
    get '', to: redirect("/#{I18n.default_locale}")

end
