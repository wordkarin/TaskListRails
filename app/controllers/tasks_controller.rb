class TasksController < ApplicationController
  before_action :check_user, only: [:edit, :update, :completed, :destroy]

  def index
    # render :index is the default behavior.
    @tasks = @current_user.tasks.order('completed ASC', 'completed_at DESC', 'created_at DESC')
  end

  def show
    begin
      task_requested = Task.find(params[:id])
      if @current_user.tasks.include? Task.find(params[:id])
        @this_task = task_requested
      else
        render "errors/wrong_user"
      end
    rescue ActiveRecord::RecordNotFound
      render "/errors/not_found", status: :not_found
    end
  end

  def new
    @task = Task.new
  end

  def create
    new_task = Task.new
    new_task.title = params[:title]
    new_task.description = params[:description]
    new_task.user_id = @current_user.id
    new_task.save

    redirect_to tasks_path
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if task_params[:completed]
      set_as_completed
    else
      task_params[:completed_at] = nil
    end

    @task.update(task_params)
    # TODO: can add in here the if statement for when update fails.
    redirect_to task_path
  end


  def completed
    @task = Task.find(params[:id])
    set_as_completed
    @task.save

    #this stores the current page in the session hash, so that I can then redirect to the same page that this completed action is called from. It also cleans it up by deleting it after it's done.
    session[:return_to] ||= request.referer
    redirect_to session.delete(:return_to)
  end

  def destroy
  # Delete the task from the database and redirect the user back to the list of remaining tasks.
    @deleting_task = Task.find(params[:id])

    @deleting_task.destroy

    redirect_to root_path
  end

  private

  def check_user
    unless @current_user.tasks.include? Task.find(params[:id])
      render 'errors/wrong_user'
    end
  end

  def set_as_completed
    #I'm only calling this from the update and completed controller actions.
    @task.completed = true
    @task.completed_at = DateTime.now
  end

  def task_params
    #TODO: is this where completed_at gets set to nil if the user unchecks the completed box?
    params.require(:task).permit(:title, :description, :completed, :completed_at)

  end
end
