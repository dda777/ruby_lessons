require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  def setup
    @user = users(:one)
    @project = @user.projects.build(title: "Test title")
  end

  test "should be valid" do
    assert @project.valid?
  end

  test "user is should be valid" do
    @project.user_id = nil
    assert_not @project.valid?
  end

  test "title should be valid" do
    @project.title = '   '
    assert_not @project.valid?
  end

  test "order should be most recent first" do
    assert_equal projects(:most_recent), Project.first
  end

end
