Rails.application.routes.draw do
  resources :news_versions
  root 'news_versions#index'
end
