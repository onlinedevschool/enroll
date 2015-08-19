Rails.application.routes.draw do
  root to: "home#index"

  get "/sitemap", controller: :sitemap,
                  action: :our_story

  with_options controller: :static do
    get "/our-story",  action: :our_story
    get "/affiliates", action: :affiliates
    get "terms",       action: :terms
    get "/privacy",    action: :privacy
  end

  resources :enrollments do
    resources :payments
  end
end
