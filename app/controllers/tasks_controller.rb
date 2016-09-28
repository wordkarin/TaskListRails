class TasksController < ApplicationController
  def index
    # render :index is the default behavior.
    @task_list = Task.all
  end

  def show
    @this_task = Task.find(params[:id])

  end
end
