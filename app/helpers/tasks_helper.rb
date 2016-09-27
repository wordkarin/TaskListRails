module TasksHelper
  def show_description
    content_tag(:p) do
      @this_task[:description]
    end
  end

  def show_status
    content_tag(:p) do
      @this_task[:completion_status]
    end
  end

  def show_date
    @this_task[:completion_date].to_s
  end
end
