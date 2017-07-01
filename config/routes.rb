Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
    resources :news_versions
  end

  root 'admin/news_versions#index'
end
