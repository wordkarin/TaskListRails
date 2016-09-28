module TasksHelper
  def show_description
    content_tag(:p) do
      @this_task[:description]
    end
  end

  def show_status
    if @this_task[:completed]
      content_tag(:p) do
        "Completed: " + @this_task[:completed_at].to_s
      end
    else
      content_tag(:p) do
        "Not Yet Completed"
      end
    end
  end

end
