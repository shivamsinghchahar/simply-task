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
end
