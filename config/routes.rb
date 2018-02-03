Rails.application.routes.draw do





  get 'histories/show'

  get 'histories/new'

  get 'histories/create'

  get 'histories/destroy'

  # get 'sessions/new'

  root 'home_page#homepage'

  get 'paginaIniziale' => 'static_pages#paginaIniziale'

  get 'studenteOProfessore' => 'static_pages#studenteOProfessore'

  get 'signupStudente' => 'user_studentes#new'

  get 'signupProfessore' => 'user_professores#new'

  get 'signupAdmin' => 'user_admins#new'

  resources :user_studentes

  resources :user_professores

  resources :user_admins

  resources :quizzes

  resources :questions

  get 'listaStudenteOProfOAdmin' => 'static_pages#listaStudenteOProfOAdmin'

  # get 'testNavFoo' => 'static_pages#testNavFoo'

  get 'login' => 'sessions#new'

  post 'login' => 'sessions#create'

  delete 'logout' => 'sessions#destroy'

  delete 'destroyMySelfAdmin' => 'user_admins#destroyMySelf'

  delete 'destroyMySelfProfessore' => 'user_professores#destroyMySelf'

  delete 'destroyMySelfStudente' => 'user_studentes#destroyMySelf'

  get 'manage' => 'manage#manage'



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


  # Righe commentate di Daria

  #get 'home_page/homepage'

  #get 'home_page/training'

  #get 'home_page/subscribeToCompetition'

  #get 'home_page/profile'

  #get 'home_page/manage'

  #get 'classification' => 'home_page#classification'

  #get 'home_page/sendRequest'

  #get 'home_page/logOut'

  #get 'home_page/noticeBoards'
end
