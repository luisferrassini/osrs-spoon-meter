Rails.application.routes.draw do
  resources :collection_logs
  resources :collection_log_items
  resources :collection_log_entries
  resources :tabs
  # Define routes for Players
  resources :players do
    # Custom route to fetch collection log
    get 'fetch_collection_log', on: :member
    
    resources :collection_logs do
      resources :tabs do
        resources :collection_log_entries do
          resources :collection_log_items do
        
          end
        end
      end
    end
  end

  resources :game_items do
    get 'fetch_drop_rate', on: :member
  end

  # Define other routes as needed
end
