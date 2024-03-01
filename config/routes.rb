Rails.application.routes.draw do
  # Define routes for Players
  resources :players do
    # Custom route to fetch collection log
    get 'fetch_collection_log', on: :member
  end

  # Define other routes as needed
end
