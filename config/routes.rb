Rails.application.routes.draw do
  root 'artists#top'

#  get "devise_users" => "artists#top"
  get "privacy" => "artists#privacy"
  get "terms" => "artists#terms"
  get "fav" => "artists#fav"
  get "login" => "users#login"
  get "my_page" => "users#my_page"
  get "report" => "tickets#report"
  post "report" => "tickets#report_send"

  resources :users, path: "/u/", param: :screen_name, :path_names => { :edit => '' }
  devise_for :devise_users, controllers: { 
    registrations: 'devise_users/registrations',                   
    sessions: 'devise_users/sessions',
    passwords: 'devise_users/passwords',
    omniauth_callbacks: 'devise_users/omniauth_callbacks'
  }
# devise_scope :user do
#   get 'sign_in',  to: 'users/sessions#new',     as: :new_user_session
#   get 'sign_out', to: 'users/sessions#destroy', as: :destroy_user_session
# end
  resources :artists, path: "/", param: :romaji do
    collection do
     get '/:romaji/sell' => 'tickets#sell',as: "sell"
     post '/:romaji/ticket_create' => 'tickets#ticket_create',as: "tickets"
     get '/:romaji/:id' => 'tickets#show'
     get '/:romaji/:id/edit' => 'tickets#edit',as: "edit_ticket"
     patch '/:romaji/:id/update' => 'tickets#update', as: "update_ticket"
     delete '/:romaji/:id/delete' => 'tickets#destroy', as: "destroy_ticket"
# delete '/chat' => 'orders#chat', as: 'chat'
   end
  end
#  get 'sign_in', :to => 'users/sessions#new', :as => :new_session
#  devise_scope :user do
#   get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
#   get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
# end
end
