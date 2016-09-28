class TasksController < ApplicationController
  def index
    # render :index is the default behavior.
    @task_list = Task.all
  end

  def show
    @this_task = Task.find(params[:id])
  end

  def create
    new_task = Task.new
    new_task.title = params[:title]
    new_task.description = params[:description]
    new_task.save

    redirect_to tasks_path
  end
end

# create a controller for your Tasks
