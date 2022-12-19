Rails.application.routes.draw do
  resources :produtos
  root to: 'usuarios#index'
  post '/login', to: 'usuarios#login'
  
  get '/logout', to: 'usuarios#logout'
  post 'cadastro', to: 'usuarios#cadastro'
  get '/cadastro', to: 'usuarios#cadastro'
  get '/home', to: 'usuarios#home'

  get "/aviso", to: 'usuarios#aviso'
  post "/aviso_verificar", to: 'usuarios#send_email'
  get 'enviar_email', to: 'usuarios#send_email'
end
