module TasksHelper
  def add_new_task
    content_tag(:h2) do
      "Add a new task"
    end
    form_tag 'tasks/new'
    #some code here to generate the form for a new task. title, description, etc.
    submit_tag "Make new task!"
  end

  def show_description
    content_tag(:p) do
      @this_task[:description]
    end
  end

  def show_status(task)
    # Want to think about how I can get this to work on both the show page and the index page. On index, I don't have instances of each task? Maybe by having show status take a parameter of which task it is.
    # form_tag "/task/#{task[:id]}/completed", method: :patch do
    #   if task[:completed]
    #     check_box_tag('completed',true, false, :onclick => "javascript: document.list.submit();")
    #   else
    #     check_box_tag('completed',false, true, :onclick => "javascript: document.list.submit();")
    #   end
    # end

    if task[:completed]
      content_tag(:p) do
        "Completed: " + task[:completed_at].to_s
      end
    else
      # label_tag do
      #   concat check_box_tag 'completed'
      form_tag "/task/#{task[:id]}/completed", method: :patch do
        label_tag do
          concat check_box_tag 'Task completed'
          concat submit_tag 'Task completed'
        end
      end
    end
  end

  def edit_task(task)
    button_to "Edit task", task_edit_path(task), method: :get
  end

  def destroy_task(task)
    # Add a route and controller action whose responsibility is deleting a task (RESTful routes)
    # On the home page, add a button or link for each task that will, once clicked...

    form_tag "/task/#{task[:id]}", method: :delete do
      submit_tag 'Delete Task', data: {confirm: "Are you sure you want to delete this task?"}
    end
  end

end
