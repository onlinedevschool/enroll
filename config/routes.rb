Rails.application.routes.draw do
  root to: "static#home"

  get "/our-story", controller: :static, action: :our_story
  get "/sitemap", controller: :sitemap, action: :index

  resources :enrollments do
    resources :payments
  end
end
