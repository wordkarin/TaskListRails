require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  test "should display the list of tasks if user is signed in" do
    # simulating that a user is logged in.
    session[:user_id] = users(:grace).id

    # Send the request, check the response
    get :index
    assert_response :success
    assert_template 'tasks/index'

    # Check that tasks match exactly
    tasks_from_controller = assigns(:tasks)

    # the number of pages returned from the controller is the same number of pages belonging to the user.
    assert_equal tasks_from_controller.length, users(:grace).tasks.length

    # making sure all pages returned from the controller is included in those pages from the user in fixtures.
    tasks_from_controller.each do |task|
      assert_includes users(:grace).tasks, task
    end
  end

  test "not-logged in user should get redirected from any page" do
    #ensure user is not logged in
    session.delete(:user_id)

    pages = [:index, :new]
    pages.each do |page|
      get page
      assert_response :redirect
      assert_redirected_to root_path
    end

    # For all the tasks in the fixtures, unregistered user cannot edit, mark as competed,  any task.
    tasks.each do |task|
      get :edit, { id: task.id }
      assert_response :redirect
      assert_redirected_to root_path

      patch :update, {id: task.id}
      assert_response :redirect_to
      assert_redirected_to root_path

      patch :completed, {id: task.id}
      assert_response :redirect_to
      assert_redirected_to root_path

      delete :destroy, {id: task.id}
      assert_response :redirect_to
      assert_redirected_to root_path 
    end
  end

  test "user should not be able to create/update " do

  end
end
