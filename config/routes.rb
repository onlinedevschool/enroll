Rails.application.routes.draw do
  devise_for :instructors
  devise_for :authors

  resources :posts, only: [:show, :index]
  get "/blog/:permalink", controller: :posts,
                            action: :show
  get "/blog", controller: :posts,
                 action: :index

  namespace :authoring do
    resources :posts
    resources :categories
    resources :series
  end
  get "/authoring" => "authoring/posts#index"

  namespace :instructors do
    resources :enrollments
    resources :students
  end

  resources :categories, only: %i[index]
  resources :series, only: %i[index]

  resources :affiliate_landings

  get "/sitemap", controller: :sitemap,
                  action: :index

  with_options controller: :static do
    get "/our-story",  action: :our_story
    get "/affiliates", action: :affiliates
    get "terms",       action: :terms
    get "/privacy",    action: :privacy
  end

  resources :enrollments do
    resources :payments
  end

  root to: "home#index"
end
