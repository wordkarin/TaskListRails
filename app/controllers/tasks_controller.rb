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

  def completed
    # This doesn't work because once you press the button theres no more ID in the params. Not sure why. 
    completed_task = Task.find(params[:id])
    completed_task.completed = true
    completed_task.completed_at = DateTime.now

    redirect_to task_path(params[:id])
  end
end

# create a controller for your Tasks
