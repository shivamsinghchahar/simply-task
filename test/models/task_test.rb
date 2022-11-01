# frozen_string_literal: true

require "test_helper"

class TaskTest < ActiveSupport::TestCase
  attr_reader :task

  def setup
    @task = build :task
  end

  def test_user_should_be_present
    task.user = nil

    assert_not task.valid?
    assert_equal "User must exist", task.errors.full_messages.to_sentence
  end

  def test_name_should_be_present
    task.name = nil

    assert_not task.valid?
    assert_equal "Name can't be blank", task.errors.full_messages.to_sentence
  end

  def test_due_date_should_be_present
    task.due_date = nil

    assert_not task.valid?
    assert_equal "Due date can't be blank", task.errors.full_messages.to_sentence
  end

  def test_returns_overdue_tasks
    user = create :user
    create_list :task, 5, user:, due_date: Date.current - 2.days, is_completed: true
    create_list :task, 5, user:, due_date: Date.current - 2.days, is_completed: false

    overdue_tasks = Task.overdue

    assert_equal 5, overdue_tasks.size
    assert overdue_tasks.pluck(:due_date).all? { |dd| dd < Date.current }
  end

  def test_returns_completed_tasks
    user = create :user
    create_list :task, 5, user:, is_completed: true
    create_list :task, 5, user:, is_completed: false

    completed_tasks = Task.completed

    assert_equal 5, completed_tasks.size
    assert completed_tasks.pluck(:is_completed).all?
  end
end
