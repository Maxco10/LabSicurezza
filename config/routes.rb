Rails.application.routes.draw do
  resources :messages
  resources :feedbacks
  resources :announcements
  resources :bookings
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks",
                                       :registrations      => "users/registrations",
                                       :sessions           => "users/sessions",
                                       :passwords         => "users/passwords",
                                       :admins            => "users/admins"
                                      }
  
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
  
  root 'home#presentazione'
  get '/profilo', to: 'home#profilo_utente'
  get '/cerca' => 'home#risultati_ricerca'
  get '/cerca_categorie', to: 'home#risultati_ricerca_categorie'
  get '/richieste_inviate', to: 'bookings#richieste_inviate'
  get '/chiudi_richiesta', to: 'bookings#chiudi_annuncio'
  get '/messaggi_inviati', to: 'messages#messaggi_inviati'
  get '/segnala_annuncio', to: 'announcements#segnala_annuncio'
  get'/miostorico',to: 'announcements#storico_oggetti_regalati'
  
  
  #Rotte funzioni admin
  get "/listaUtenti", to: 'users/admins#listaUtenti'
  get "/listaAnnunci", to: 'users/admins#listaAnnunci'
  get "/faiAdmin", to: 'users/admins#faiAdmin'
  get "/modificaUtente_show", to: 'users/admins#modificaUtente_show'
  post "/modificaUtente_update", to: 'users/admins#modificaUtente_update'
  get "/annunciSegnalati", to: 'users/admins#annunciSegnalati'
  get "/togliSegnalato", to: 'users/admins#togliSegnalato'
  get "/modificaAnnuncio_show", to: 'users/admins#modificaAnnuncio_show'
  post "/modificaAnnuncio_update", to: 'users/admins#modificaAnnuncio_update'
  get "/chiudiAnnuncio", to: 'users/admins#chiudiAnnuncio'
  get "/apriAnnuncio", to: 'users/admins#apriAnnuncio'
  get "/listaPrenotazioni", to: "users/admins#listaPrenotazioni"
  
  get "/banna_show", to: "users/admins#banna_show"
  post "/banna_action", to: "users/admins#banna_action"
  get "/togliBan", to: "users/admins#togliBan"
  
  
end
