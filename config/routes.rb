Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: %i[create destroy] do
        resources :sleep_sessions, only: :index do
          collection do
            post 'clock_in', to: 'sleep_sessions#clock_in'
            patch 'clock_out', to: 'sleep_sessions#clock_out'
          end
        end
      end
    end
  end
end
