# frozen_string_literal: true

require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  attr_reader :user, :task

  def setup
    @user = create :user
    @task = create :task, user:
  end

  def test_should_get_index
    login user
    get tasks_path

    assert_equal "index", @controller.action_name
    assert_response :success
  end

  def test_should_redirect_index_if_not_logged_in
    get tasks_path

    assert_equal "index", @controller.action_name
    assert_redirected_to new_session_path
  end

  def test_should_return_all_tasks
    create_tasks
    login user
    get tasks_path

    assert_equal "index", @controller.action_name
    assert_select "tbody tr", Task.count
  end

  def test_should_return_overdue_tasks
    create_tasks
    login user
    get tasks_path(status: :overdue)

    assert_equal "index", @controller.action_name
    assert_select "tbody tr", Task.overdue.count
  end

  def test_should_return_completed_tasks
    create_tasks
    login user
    get tasks_path(status: :completed)

    assert_equal "index", @controller.action_name
    assert_select "tbody tr", Task.completed.count
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

  def test_should_get_edit
    login user
    get edit_task_path(task)

    assert_equal "edit", @controller.action_name
    assert_response :success
  end

  def test_should_redirect_edit_if_not_logged_in
    get edit_task_path(task)

    assert_equal "edit", @controller.action_name
    assert_redirected_to new_session_path
  end

  def test_should_update_task_with_valid_attributes
    login user
    assert_changes 'task.reload.name' do
      put task_path(task), params: { task: { name: "New name" } }
    end

    assert_equal "update", @controller.action_name
    assert_equal "Successfully updated task", flash[:notice]
  end

  def test_should_not_update_task_with_invalid_attributes
    login user
    assert_no_changes 'task.reload.name' do
      put task_path(task), params: { task: { name: "" } }
    end

    assert_equal "update", @controller.action_name
    assert_response :unprocessable_entity
  end

  def test_should_redirect_update_if_not_logged_in
    put task_path(task), params: { task: attributes_for(:task).except(:user_id) }

    assert_equal "update", @controller.action_name
    assert_redirected_to new_session_path
  end

  def test_should_destroy_task
    login user
    assert_changes 'Task.count' do
      delete task_path(task)
    end

    assert_equal "destroy", @controller.action_name
  end

  def test_should_not_destroy_task_if_not_logged_in
    assert_no_changes 'Task.count' do
      delete task_path(task)
    end

    assert_equal "destroy", @controller.action_name
    assert_redirected_to new_session_path
  end

  def test_should_mark_task_as_completed
    login user
    assert_changes 'task.reload.is_completed' do
      patch mark_as_complete_task_path(task)
    end

    assert_equal "mark_as_complete", @controller.action_name
  end

  def test_should_not_mark_task_as_complete_if_not_logged_in
    assert_no_changes 'task.reload.is_completed' do
      patch mark_as_complete_task_path(task)
    end

    assert_equal "mark_as_complete", @controller.action_name
    assert_redirected_to new_session_path
  end

  private
    def create_tasks
      create_list :task, 5, user:, due_date: Date.current
      create_list :task, 5, user:, due_date: Date.current, is_completed: true
      create_list :task, 5, user:, due_date: Date.current - 2.days
    end
end
