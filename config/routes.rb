Rails.application.routes.draw do

  get 'configurations/edit'

    root 'accounts#new'
    resources :configurations, only: [:edit, :update]
    resources :userss
    resources :accounts do
      put '/correction' => 'accounts#correction'
    end
    devise_for :users
    get '*path', to: redirect("/#{I18n.default_locale}/%path")
    get '', to: redirect("/#{I18n.default_locale}")

end
