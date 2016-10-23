require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user with valid credentials can be saved" do
    grace = users(:grace)
    assert grace.valid?

    no_tasks = users(:no_tasks)
    assert no_tasks.valid?

  end

  test "user without email, uid, or provider is not valid" do
    no_email = users(:grace)
    no_email.email = nil
    assert_not no_email.valid?

    no_provider = users(:no_tasks)
    no_provider.provider = nil
    assert_not no_provider.valid?

    no_uid = users(:grace)
    no_uid.uid = nil
    assert_not no_uid.valid?
  end

  test "can create a valid new user from github" do
    auth_hash = OmniAuth.config.mock_auth[:github]
    gh_built = User.build_from_github(auth_hash)

    assert gh_built.valid?
  end
end
