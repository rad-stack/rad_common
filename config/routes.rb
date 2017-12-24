RadCommon::Engine.routes.draw do
  get "global_search", to: "search#global_search"
  get "global_search_result", to: "search#global_search_result"

  resources :companies, only: [] do
    post :global_validity_check, on: :member
  end

  resources :system_messages, only: %i[new create]
end
