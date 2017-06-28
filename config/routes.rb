Rails.application.routes.draw do
  namespace :admin do
    resources :news_versions
  end

  root 'news_versions#index'
end
