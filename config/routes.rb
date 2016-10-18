Rails.application.routes.draw do
  root 'tasks#index'
  # get '/tasks' => 'tasks#index'
  # post '/tasks' => 'tasks#create'
  # get 'tasks/new' => 'tasks#new'
  # get 'tasks/:id/edit', to: 'tasks#edit', as: 'task_edit'
  #
  # get '/tasks/:id', to: 'tasks#show', as: 'task'
  #
  # patch 'tasks/:id', to: 'tasks#update'
  # delete '/task/:id' => 'tasks#destroy'

  resources :tasks

  patch '/task/:id/completed' => 'tasks#completed'

  get "/auth/:provider/callback" => "sessions#create"

  delete "/sessions", to: "sessions#destroy", as: "logout"

# Set up necessary controller(s) and route(s) that you will need in order to show a task from the database

# Create a root route for your application that directs users to the list of all tasks

end
