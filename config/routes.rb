Rails.application.routes.draw do

  root 'home_page#homepage'

  get 'paginaIniziale' => 'static_pages#paginaIniziale'

  get 'studenteOProfessore' => 'static_pages#studenteOProfessore'

  get 'signupStudente' => 'user_studentes#newStudente'

  get 'signupStudenteNew' => 'user_studentes#new'

  get 'signupProfessore' => 'user_professores#newProfessore'

  get 'signupProfessoreNew' => 'user_professores#new'

  get 'signupAdmin' => 'user_admins#newAdmin'

  get 'signupAdminNew' => 'user_admins#new'

  get 'editStudenteNow' => 'user_studentes#editStudenteNow'

  get 'editProfessoreNow' => 'user_professores#editProfessoreNow'

  get 'editAdminNow' => 'user_admins#editAdminNow'

  get 'newAdvice' => 'advices#new'

  resources :user_studentes

  resources :user_professores

  resources :user_admins

  resources :questions, only: [:edit, :update, :index, :show, :destroy, :create]
  
  resources :pretest_and_exam_quizs, only: [:edit, :update, :show]

  resources :histories, only: [:index]

  resources :advices

  resources :account_activations, only: [:edit]

  resources :password_resets, only: [:new, :create, :edit, :update]

  get 'listaStudenteOProfOAdmin' => 'static_pages#listaStudenteOProfOAdmin'

  get 'trainingPage' => 'static_pages#trainingPage'

  get 'competition' => 'static_pages#competition'
  
  get 'subscribeBeforeTest' => 'static_pages#subscribeBeforeTest'

  # get 'testNavFoo' => 'static_pages#testNavFoo'

  get 'login' => 'sessions#new'

  post 'login' => 'sessions#create'

  post 'loginAdmin' => 'sessions#createAdmin'

  post 'loginProfessore' => 'sessions#createProfessore'

  post 'loginStudente' => 'sessions#createStudente'

  delete 'logout' => 'sessions#destroy'

  delete 'destroyMySelfAdmin' => 'user_admins#destroyMySelf'

  delete 'destroyMySelfProfessore' => 'user_professores#destroyMySelf'

  delete 'destroyMySelfStudente' => 'user_studentes#destroyMySelf'

  get 'manage' => 'manage#manage'

  get 'changeAdministratorsPassword' => 'pw_new_admins#editAdministratorsPassword'

  post 'changeAdministratorsPassword' => 'pw_new_admins#updateAdministratorsPassword'

  get 'changeProfessorsPassword' => 'pw_new_professores#editProfessorsPassword'

  post 'changeProfessorsPassword' => 'pw_new_professores#updateProfessorsPassword'

  get 'manageSurveyOrActivationPage' => 'survey_activations#manageSurveyOrActivationPage'

  get 'manageSurvey' => 'survey_activations#manageSurvey'

  get 'activeSurveyPage' => 'survey_activations#activationPage'

  get 'activeSurvey' => 'survey_activations#activation'

  get 'doSurvey' => 'survey_activations#doSurvey'

  get 'trainingQuestionsManage' => 'static_pages#trainingQuestionsManage'

  get 'newQuestion' => 'questions#new'

  get 'newCasual' => 'quizzes#newCasual'

  get 'trainingTestDonePage' => 'quizzes#trainingTestDonePage'

  post 'trainingTestDone' => 'quizzes#trainingTestDone'
  
  get 'manageSubscribeOrExamActivation' => 'subscribe_and_exam_activations#manageSubscribeOrExamActivation'
  
  get 'activeSubscribePage' => 'subscribe_and_exam_activations#subscribeActivationPage'

  get 'activeSubscribe' => 'subscribe_and_exam_activations#subscribeActivation'
  
  get 'activeExamPage' => 'subscribe_and_exam_activations#examActivationPage'

  get 'activeExam' => 'subscribe_and_exam_activations#examActivation'
  
  get 'pretest' => 'pretest_and_exam_quizs#pretest'
  
  get 'pretestDonePage' => 'pretest_and_exam_quizs#pretestDonePage'

  post 'pretestDone' => 'pretest_and_exam_quizs#pretestDone'
  
  get 'getAnotherOTP' => 'pretest_and_exam_quizs#getAnotherOTP'
  
  get 'insertOTPPage' => 'pretest_and_exam_quizs#insertOTPPage'
  
  post 'verifyOTP' => 'pretest_and_exam_quizs#verifyOTP'
  
  get 'exam' => 'pretest_and_exam_quizs#exam'
  
  get 'examDonePage' => 'pretest_and_exam_quizs#examDonePage'
  
  post 'examDone' => 'pretest_and_exam_quizs#examDone'
  
  get 'giveUp' => 'pretest_and_exam_quizs#giveUp'
  
  get 'selectClassification' => 'classifications#selectClassification'
  
  get 'trainingClassificationSelectYear' => 'classifications#trainingClassificationSelectYear'
  
  post 'trainingClassification' => 'classifications#trainingClassification'
  
  get 'partecipantsClassificationSelectYear' => 'classifications#partecipantsClassificationSelectYear'
  
  post 'partecipantsClassification' => 'classifications#partecipantsClassification'
  
  get 'postExamClassificationSelectYear' => 'classifications#postExamClassificationSelectYear'
  
  post 'postExamClassification' => 'classifications#postExamClassification'
  
  post 'addToWinners' => 'classifications#addToWinners'
  
  get 'winnersClassificationSelectYear' => 'classifications#winnersClassificationSelectYear'
  
  post 'winnersClassification' => 'classifications#winnersClassification'
  
  post 'editWinners' => 'classifications#editWinners'
  
  post 'removeWinner' => 'classifications#removeWinner'



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
