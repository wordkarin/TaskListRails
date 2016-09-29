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
    completed_task = Task.find(params[:id])
    completed_task.completed = true
    completed_task.completed_at = DateTime.now

    completed_task.save

    redirect_to task_path(params[:id])
  end

  def delete
    @deleting_task = Task.find(params[:id])

    @deleting_task.destroy

    redirect_to root_path
  end
end
