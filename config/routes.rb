Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
    resources :news_versions
  end

  get 'news_versions/activate_version' => 'admin/news_versions#activate_version'
  get 'news_versions/remove_draft' => 'admin/news_versions#remove_draft'

  patch '/admin/news_versions' => 'admin/news_versions#update'
  put '/admin/news_versions' => 'admin/news_versions#update'

  root 'admin/news_versions#index'
end