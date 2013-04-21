TestJpl::Application.routes.draw do

  devise_for :admins, :skip => [:registrations]
  
  as :admin do
    get 'admins/edit' => 'devise/registrations#edit', :as => 'edit_admin_registration'
    get 'albums/:album_id/images/:id/admin' => 'images#adminShow', :as => 'admin_show'
  end

  devise_for :users, :controllers => {:registrations => "registrations"}

  resources :votes
  resources :comments
  resources :users
  resources :admins 
  resources :responses
  resources :tags

  match "albums/responded" => "albums#responded"
  resources :albums do
    resources :images do
    end
  end
  
  match "albums/:album_id/images/:image_id/tags" => "tags#create", :via => :post
  match "albums/:album_id/images/:image_id/tags" => "tags#index", :via => :get
  #match "albums/:album_id/images/:image_id/show" => "tags#show"
  #match "albums/:album_id/images/:image_id/deletetag" => "tags#delete"
  
  get "albums/popular"
  root :to => 'albums#popular'
  #get "images/tagTest"
  #match 'images/:id/tags' => 'images#tagTest'

  #get "images/ajaxTest"
  #get "images/tagTest"
  #root :to => 'images#tagTest'
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
