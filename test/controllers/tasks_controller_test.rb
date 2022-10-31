# frozen_string_literal: true

require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  attr_reader :user

  def setup
    @user = create :user
  end

  def test_should_get_new
    login user
    get new_task_path

    assert_equal "new", @controller.action_name
    assert_response :success
  end

  def test_should_redirect_new_if_not_logged_in
    get new_task_path

    assert_equal "new", @controller.action_name
    assert_redirected_to new_session_path
  end

  def test_should_create_valid_task
    login user
    assert_difference -> { user.tasks.count } do
      post tasks_path, params: { task: attributes_for(:task).except(:user_id) }
    end

    assert_equal "create", @controller.action_name
    assert_equal "Successfully added task", flash[:notice]
  end

  def test_should_not_create_invalid_task
    login user
    assert_no_difference -> { user.tasks.count } do
      post tasks_path, params: { task: attributes_for(:task).except(:user_id).merge(name: "") }
    end

    assert_equal "create", @controller.action_name
    assert_response :unprocessable_entity
  end

  def test_should_redirect_create_if_not_logged_in
    post tasks_path, params: { task: attributes_for(:task).except(:user_id) }

    assert_equal "create", @controller.action_name
    assert_redirected_to new_session_path
  end
end
