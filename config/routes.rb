Rails.application.routes.draw do
  namespace :api, :defaults => {:format => :json}  do
    namespace :v1 do
      resources :wars, only: [:index]
      resources :rank_types, only: [:index]
      resources :medical_condition_types, only: [:index]
      resources :medical_condition_names, only: [:index]
      resources :ranks, only: [:index]
      resources :branches, only: [:index]
      resources :awards, only: [:index]
      resources :name_suffixes, only: [:index]
      resources :contact_relationships, only: [:index]
      resources :contact_categories, only: [:index]
      resources :shirt_sizes, only: [:index]
      resources :people, only: [:create, :update] do
        resources :service_histories, shallow: true, only: [:create, :update] do
          resources :service_awards, shallow: true, only: [:index, :destroy]
        end
        resources :contacts, shallow: true, only: [:create, :update]
        resources :medical_conditions, shallow: true, only: [:index, :create, :destroy]
      end

      get 'simple_pages/:key', to: 'simple_pages#show', defaults: { format: 'json' }
    end
  end


  post 'sms/receiver' => 'sms#receiver', as: :sms
  post 'sms/receiver2' => 'sms#receiver', as: :sms2
  get 'status' => 'status#index', as: :status


  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
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
  root to: "admin/dashboard#index"

  #Mount Sidekiq at '/jobs' if they are an admin user
  # require 'sidekiq/web'
  # authenticate :admin_user do
  #   mount Sidekiq::Web, at: '/jobs'
  # end
end
