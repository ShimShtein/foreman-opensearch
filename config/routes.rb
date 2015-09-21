Rails.application.routes.draw do
  scope module: 'ForemanOpensearch' do
    get 'search', to: 'opensearch#search'
    get 'opensearch/description', to: 'opensearch#description'
  end
end
