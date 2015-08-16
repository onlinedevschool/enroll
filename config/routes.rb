Rails.application.routes.draw do
  root to: "static#home"

  resources :enrollments do
    resources :payments
  end
end
