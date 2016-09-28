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
      # label_tag do
      #   concat check_box_tag 'completed'
      form_tag '/task' do
        submit_tag 'Completed!'
      end
    end
  end

end
