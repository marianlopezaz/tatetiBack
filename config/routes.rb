# POST /v1/game/
# POST /v1/game/newmovement

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :v1, default: { format: :json } do
    resources :game, only: [:index, :create, :destroy] do
      collection do
        post :newmovement
      end
  end
end

end
