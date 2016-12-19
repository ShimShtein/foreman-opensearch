Rails.application.routes.draw do
  namespace :foreman_opensearch do
    get 'search', controller: 'opensearch', action: :search
    get 'description', to: 'opensearch#description'
    get 'autocomplete', to: 'opensearch#autocomplete'
  end
end
