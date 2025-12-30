Rails.application.routes.draw do
  resources :messages

  resources :contacts, only: [:index, :create]

  devise_for :users,
             defaults: { format: :json },
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             },
             path_names: {
               sign_in: 'login',
               sign_out: 'logout'
             }
end