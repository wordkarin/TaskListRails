class TasksController < ApplicationController
  def index
    # render :index is the default behavior.
    @task_list = Task.all
  end

  def show
    @this_task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    new_task = Task.new
    new_task.title = params[:title]
    new_task.description = params[:description]
    new_task.save

    redirect_to tasks_path
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @task.update(task_params)
    # TODO: can add in here the if statement for when update fails.
    redirect_to task_path
  end

  def completed
    completed_task = Task.find(params[:id])
    completed_task.completed = true
    completed_task.completed_at = DateTime.now

    completed_task.save

    redirect_to task_path(params[:id])
  end

  def destroy
  # Delete the task from the database and redirect the user back to the list of remaining tasks.
    @deleting_task = Task.find(params[:id])

    @deleting_task.destroy

    redirect_to root_path
  end

  private

  def task_params
    #TODO: is this where completed_at gets set to nil if the user unchecks the completed box?
    params.require(:task).permit(:title, :description, :completed)

  end
end
