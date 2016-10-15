Rails.application.routes.draw do

  get "lightinthebox-products" => "lightinthebox#index"
  post "toggle-product" => "lightinthebox#toggle"

  get "aliexpress-products" => "aliexpress#products"

  post "aliexpress/toggle-product" => "aliexpress#toggle"

  resources :aliexpress, :only => [] do
    collection do
      post "/export" => "aliexpress#export"
    end
  end

  resources :app, :only => [] do
    collection do
      get "/best_sale" => "app_best_sell_products#index"
    end
  end
end
