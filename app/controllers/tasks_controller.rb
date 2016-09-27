class TasksController < ApplicationController
  def index
    # render :index is the default behavior.
    @task_list = [
      {
        name: "laundry",
        description: "wash all the things",
        completion_status: "not started",
        completion_date: Date.new(2016, 9, 30)
      },
      {
        name: "thank you cards",
        description: "write thank you cards for grandma and aunt nobuko",
        completion_status: "in progress",
        completion_date: Date.new(2016, 9, 28)
      },
      {
        name: "grocery shopping",
        description: "need to get some foods",
        completion_status: "not started",
        completion_date: Date.new(2016, 9, 27)
      },
      {
        name: "make kids christmas presents",
        description: "make a mini stamp set for ada",
        completion_status: "not started",
        completion_date: Date.new(2016, 12, 20)
      },
      {
        name: "get knives sharpened",
        description: "take knives to seattle edge",
        completion_status: "not started",
        completion_date: Date.new(2016, 10, 10)
      },
    ]
  end

  def show
    task_list = [
      {
        name: "laundry",
        description: "wash all the things",
        completion_status: "not started",
        completion_date: Date.new(2016, 9, 30)
      },
      {
        name: "thank you cards",
        description: "write thank you cards for grandma and aunt nobuko",
        completion_status: "in progress",
        completion_date: Date.new(2016, 9, 28)
      },
      {
        name: "grocery shopping",
        description: "need to get some foods",
        completion_status: "not started",
        completion_date: Date.new(2016, 9, 27)
      },
      {
        name: "make kids christmas presents",
        description: "make a mini stamp set for ada",
        completion_status: "not started",
        completion_date: Date.new(2016, 12, 20)
      },
      {
        name: "get knives sharpened",
        description: "take knives to seattle edge",
        completion_status: "not started",
        completion_date: Date.new(2016, 10, 10)
      },
    ]


    begin
      task_id = Integer(params[:id])

      if task_id >= 0 && task_id < task_list.length
        @this_task = task_list[task_id] #this will be a hash for the task
      else
        @this_task = "Invalid task ID"
        render status: 404
      end
    rescue ArgumentError
      @this_task = "Invalid task ID"
      render status: 404
    end
  end
end
