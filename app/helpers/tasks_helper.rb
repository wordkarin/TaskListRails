module TasksHelper
  def show_description
    content_tag(:p) do
      @this_task[:description]
    end
  end

  def show_status(task)
    # Want to think about how I can get this to work on both the show page and the index page. On index, I don't have instances of each task? Maybe by having show status take a parameter of which task it is.
    if task[:completed]
      content_tag(:p) do
        "Completed: " + task[:completed_at].to_s
      end
    else
      # label_tag do
      #   concat check_box_tag 'completed'
      form_tag "/task/#{task[:id]}", method: :patch do
        submit_tag 'Completed!'
      end
    end
  end

  def delete_task(task)
    # Add a route and controller action whose responsibility is deleting a task (RESTful routes)

    form_tag "/task/#{task[:id]}", method: :delete do
      submit_tag 'Delete Task', data: {confirm: "Are you sure you want to delete this task?"}
    end
  end

  def confirm_delete(task)
    # <%= link_to "Do something", {:controller => "foo", :action => "bar"}, :confirm => "Are you sure you want to do that?" %>
  end

end
