# frozen_string_literal: true

module TaskHelper
  def task_status(task)
    return "completed" if task.is_completed
    return "overdue" if task.due_date < Date.current
    "pending"
  end
end
