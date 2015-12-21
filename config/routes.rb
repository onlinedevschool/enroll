Rails.application.routes.draw do
  devise_for :instructors

  namespace :instructors do
    resources :enrollment_applications, only: %i[index destroy]
    resources :student_interview_invitations, only: %i[create]
    resources :students
    resources :private_sessions
  end

  resources :affiliate_landings

  get "/sitemap", controller: :sitemap,
                  action: :index

  resources :enrollments do
    resources :payments
  end
end
