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
      form_tag ('/task/' + task[:id].to_s) do
        submit_tag 'Completed!'
      end
    end
  end

end
