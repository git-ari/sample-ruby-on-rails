Rails.application.routes.draw do
  resources :comments
  resources :posts
  get '/comments/post/:id', to: 'comments#show_by_post'
  put '/posts/:id/upload', to: 'posts#upload'
  get '/triangle/:a/:b/:c', to: 'triangles#calculate'

  # post 'auth-tests/basic', to: 'auth_tests#basic'
  # post 'auth-tests/api-key', to: 'auth_tests#api_key'
  # post 'auth-tests/basic-and-api-key', to: 'auth_tests#basic_and_api_key'

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
