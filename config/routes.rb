BaseApp::Application.routes.draw do

  #get "crawler/index"
  resource :crawler
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get "reserves/show"
  get "/reserves/feed"
  match 'reserves/book/:year/:month/:day/:hour' => 'reserves#book', :via => :get

  get "/admin" => "admin/base#index", :as => "admin"

  namespace "admin" do
    resources :users
  end

  #root :to => "reserves#index"
  root :to => "crawlers#show"
end
