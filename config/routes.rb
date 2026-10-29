Rails.application.routes.draw do
  resources :notes

  resources :teams, only: [] do
    resources :notes, only: [:index], controller: :team_notes
  end

  resources :users, only: [] do
    resources :notes, only: [:index], controller: :user_notes
  end
end
