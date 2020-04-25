Rails.application.routes.draw do

  # Authorization
  devise_for :users

  # Oauth return
  get '/auth/:provider/callback', to: 'manage/providers#authorize'
  get '/auth/:provider/setup', to: 'manage/providers#setup'

  # Admin routes
  namespace :manage do
    resource :site
    resources :pages do
      collection do
        post 'reorder'
      end
    end
    resources :providers do
      collection do
        get 'authorize'
      end
    end
  end

  # Shortcuts
  get '/manage', to: 'manage/sites#show'

  # Home
  get '/site/update', to: 'site#update'
  get '/:slug', to: 'site#show'
  root 'site#home'

end
