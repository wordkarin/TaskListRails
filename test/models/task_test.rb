require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test "task belongs to a user" do
    assert_respond_to tasks(:one), :user
    assert_equal tasks(:one).user, users(:grace)
  end

  test "task with title and description is valid" do
    assert tasks(:one).valid?
    assert tasks(:two).valid?
  end

  test "task without title/description is invalid" do
    no_title = tasks(:one)
    no_title.title = nil
    assert_not no_title.valid?

    no_desc = tasks(:one)
    no_desc.description = nil
    assert_not no_desc.valid?
  end

  test "task that doesn't belong to a user is invalid" do
    no_user = tasks(:one)
    no_user.user = nil
    assert_not no_user.valid?
  end
end
