CimpaApplication::Application.routes.draw do
  get "evaluators/index", as: :evaluators
  post "evaluators/set_evaluator1/:presentation_id" => "evaluators#set_evaluator1", as: :set_evaluator1
  post "evaluators/set_evaluator2/:presentation_id" => "evaluators#set_evaluator2", as: :set_evaluator2
  resources :currencies
  get 'presentations/:id/download_tentative_schedule_file' => 'presentations#download_tentative_schedule_file', :as => :download_tentative_schedule_file

  get 'presentations/:id/download_administration_cv' => 'presentations#download_administration_cv', :as => :download_administration_cv
  get 'presentations/:id/download_scientific_cv' => 'presentations#download_scientific_cv', :as => :download_scientific_cv
  get 'presentations/:id/pre_proposal' => 'presentations#pre_proposal', :as => :pre_proposal
  get 'presentations/:id/show_pre_proposal' => 'presentations#show_pre_proposal', :as => :show_pre_proposal
  get 'presentations/:id/final_proposal' => 'presentations#final_proposal', :as => :final_proposal
  get 'presentations/:id/cancel_proposal' => 'presentations#cancel_proposal', as: :cancel_proposal
  resources :presentations do
    resources :evaluation1, only: [:new, :edit, :create, :update]
    resources :evaluation2, only: [:new, :edit, :create, :update]
    resources :synthesis1, only: [:new, :edit, :create, :update]
    resources :synthesis2, only: [:new, :edit, :create, :update]
  end

  devise_for :users
  resources :friends

  resources :people

  get "main/index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'main#index'

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
