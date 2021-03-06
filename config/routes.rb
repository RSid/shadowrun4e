Rails.application.routes.draw do
  devise_for :views
  devise_for :users

  namespace :admin do
    resources :users, only: [:index, :edit, :update, :destroy]
    resources :characters, only: [:index, :edit, :update, :destroy]

    resources :inventory, only: [:index]
    resources :skills
    resources :qualities
    resources :connections
    resources :tools
    resources :armors
    resources :weapons
    resources :crafts
    resources :cyberbiowares
  end

  get '/about' => 'pages#about'
  get '/admin-dash' => 'pages#admin_dash'
  root 'pages#landing'

  resources :characters, only: [:index, :show, :new, :create, :destroy, :update, :edit] do

    resources :character_skills, only: [:new, :create, :destroy, :index]

    resources :skills, only: [:new, :create]

    resources :character_qualities, only: [:new, :create, :destroy, :index]

    resources :qualities, only: [:new, :create]

    resources :connections, only: [:new, :create, :destroy, :index]

    resources :inventory, only: [:index]

    resources :tools, only: [:new, :create]

    resources :character_tools, only: [:new, :create, :destroy, :index]

    resources :armors, only: [:new, :create]

    resources :character_armors, only: [:new, :create, :destroy, :index]

    resources :weapons, only: [:new, :create]

    resources :character_weapons, only: [:new, :create, :destroy, :index]

    resources :crafts, only: [:new, :create]

    resources :character_crafts, only: [:new, :create, :destroy, :index]

    resources :cyberbiowares, only: [:new, :create]

    resources :character_cyberbiowares, only: [:new, :create, :destroy, :index]
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
