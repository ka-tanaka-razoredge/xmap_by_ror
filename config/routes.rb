Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
get '/component/index', to: 'component#index'
get '/component/show/:id', to: 'component#show'
get '/component/index_for_containers', to: 'component#index_for_containers'
get '/associative_component/index', to: 'associative_component#index'
get '/associative_component/index_shallowly', to: 'associative_component#index_shallowly'
end
