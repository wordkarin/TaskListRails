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

    #ensure that unregistered user cannot create a new task.

    post :create
    assert_response :redirect
    assert_redirected_to root_path

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

  test "user gets error if tries to view/edit/update/delete another user's task" do
    # simulating that a user is logged in.
    session[:user_id] = users(:grace).id

    task = tasks(:three)
    assert_not_equal task.user, users(:grace)

    get :show, {id: task.id}
    assert_template 'errors/wrong_user'

    get :edit, {id: task.id}
    assert_template 'errors/wrong_user'

    patch :update, {id: task.id}
    assert_template 'errors/wrong_user'

    patch :completed, {id: task.id}
    assert_template 'errors/wrong_user'

    delete :destroy, {id: task.id}
    assert_template 'errors/wrong_user'
  end

  test "logged in user creates new task, task belongs to that user" do
    # simulating that a user is logged in.
    grace = users(:grace)
    session[:user_id] = grace.id

    task_params = {title: "a title", description: "a description"}

    assert_difference('Task.count', 1) do
      post :create, task_params
    end

    # The task I just created is the last one?
    assert_equal Task.last.user_id, grace.id
  end

  test "as a logged in user, I can edit my own task" do
    # simulating that a user is logged in.
    grace = users(:grace)
    session[:user_id] = grace.id

    task = tasks(:one)


    assert_equal task.user, users(:grace)

    get :edit, {id: task.id}
    assert_response :success
    assert_template :edit
  end

  test "as a logged in user, I can update my own task" do

    session[:user_id] = users(:grace).id

    task = tasks(:one)

    task.description = "I updated this description"

    patch :update, { id: tasks(:one).id, task: task.attributes }

    assert_redirected_to task_path(assigns(:task))

    # TODO: I want to test that as a logged in user I can complete a task, but I've been wrestling with it for an hour and am going to stop. 
    # task.completed = true
    # task.completed_at = DateTime.now
    #
    # patch :completed, { id: tasks(:one).id, task: task.attributes}
    #
    # assert_response :redirect

    delete :destroy, {id: task.id}
    assert_response :redirect
    assert_redirected_to root_path
  end

end
