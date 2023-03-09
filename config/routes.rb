Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: %i[create destroy] do
        post 'follow/:follower_id', to: 'relationships#follow'
        delete 'unfollow/:follower_id', to: 'relationships#unfollow'

        resources :sleep_sessions, only: :index do
          collection do
            post 'clock_in', to: 'sleep_sessions#clock_in'
            patch 'clock_out', to: 'sleep_sessions#clock_out'
            get 'friends', to: 'sleep_sessions#friends'
          end
        end
      end
    end
  end
end
