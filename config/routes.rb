Rails.application.routes.draw do
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

  resources :contacts do
    resources :messages
  end

  # avatar upload
  patch "/users/avatar", to: "users#update_avatar"

  # info do usuário logado
  get "/users/me", to: "users#me"
end
