Rails.application.routes.draw do
  root 'tasks#index'
  get '/tasks' => 'tasks#index'
  get 'tasks/new' => 'tasks#new'
  post '/tasks' => 'tasks#create'

  get '/tasks/:id', to: 'tasks#show', as: 'task'

  get 'tasks/:id/edit', to: 'tasks#edit', as: 'task_edit'
  patch 'tasks/:id', to: 'tasks#update'

  patch '/task/:id/completed' => 'tasks#completed'

  delete '/task/:id' => 'tasks#destroy'

# Set up necessary controller(s) and route(s) that you will need in order to show a task from the database

# Create a root route for your application that directs users to the list of all tasks

end
