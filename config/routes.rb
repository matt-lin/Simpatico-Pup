Ratemypup::Application.routes.draw do

  get 'feedback/index'

  get 'feedback/new'

  get 'feedback/show'

  get 'feedback/thanks'

  mount Rich::Engine => '/rich', :as => 'rich'
  # get 'password_resets/new'

  # get 'password_resets/edit'

  mount Thredded::Engine => '/forum'
  devise_for :users, controllers: {sessions: "sessions", registrations: 'users/registrations'}

  post '/users/profile/edit' => 'users/profile#edit_image', :as => :edit_profile_image

  # namespace :users do
  #   get '/pups' => 'users#pups', :as => :user_pups
  # end

  get '/users/pups' => 'users#pups', :as => :user_pups
  get '/users/profile/:user_id' => "users/profile#index", :as => :profile_page
  post '/users/profile/bio' => "users/profile#bio", :as => :profile_bio

  devise_scope :user do
    get '/users/unsubscribe' => 'users/registrations#unsubscribe_newsletter', :as => :unsubscribe_newsletter
    post '/users/update_subscription' => 'users/registrations#update_subscription', :as => :update_subscription
  end

  root :to => 'pups#main'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # devise_for :users, controllers: { registrations: 'users/registrations'}
  # ActiveAdmin.routes(self)

  match '/pups/create' => 'pups#create', :as => :create_pup, via: [:get, :post]
  # match '/breeders/create' => 'breeders#create', :as => :create_breeder
  post 'breeders' => 'breeders#create', :as => :create_breeder
  get 'pups/dog_name' => 'pups#dog_name', :as => :dog_name
  get 'pups/dog_how_long' => 'pups#dog_how_long', :as => :dog_how_long
  get 'pups/dog_breed' => 'pups#dog_breed', :as => :dog_breed
  get 'pups/dog_breeder' => 'pups#dog_breeder', :as => :dog_breeder

  get 'pups/hashtags' => 'pups#hashtags', :as => :dog_hashtags
  get 'pups/random_comment' => 'pups#random_comment', :as => :dog_random_comment
  get 'pups/ratings' => 'pups#ratings', :as => :dog_ratings
  get 'pups/breed_avg_ratings' => 'pups#breed_avg_ratings', :as => :breed_avg_ratings

  # resources :feedback
  resources :pups
  resources :breeders
  resources :texts
  resources :passwordresets
  # activate account
  resources :account_activations, only: [:edit]

  get '/activate/:email' => 'account_activations#send_mail', :as => :activate, :constraints => { :email => /.+@.+\..*/ }

  get '/feedback' => 'feedback#new', :as => :feedback
  post '/feedback/create' => 'feedback#create', :as => :create_feedback
  get '/feedback/thanks' => 'feedback#thanks', :as => :thanks_feedback

  get '/breed' => 'pups#breed', :as => :breed
  get '/breed/match' => 'pups#search_breed', :as => :breed_search
  get '/breeder/search_name' => 'breeders#search_name', :as => :breeder_search
  get '/breeder/match' => 'breeders#search_breeder', :as => :breeder_substring_match
  get '/search_nearer_breeders' => 'breeders#search_nearer_breeders', as: :search_nearer_breeders
  get '/nearer_breeders' => 'breeders#nearer_breeders', as: :nearer_breeders

  get '/text/mission' => 'texts#mission', :as => :text_mission
  get '/text/background' => 'texts#background', :as => :text_background
  get '/text/goals' => 'texts#goals', :as => :text_goals
  get '/text/how_you_can_help' => 'texts#how_you_can_help', :as => :text_how_you_can_help
  get '/text/privacy_policy' => 'texts#privacy_policy', :as => :privacy_policy
  get '/text/terms_of_service' => 'texts#terms_of_service', :as => :terms_of_service
  get '/welcome' => 'texts#welcome', :as => :welcome

  get "*path" => redirect("/")

  # The priority is based upon order of creation:
  # first created -> highest priority.
  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
