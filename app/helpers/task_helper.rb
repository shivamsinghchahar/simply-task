# frozen_string_literal: true

module TaskHelper
  def task_status(task)
    return "completed" if task.is_completed
    return "overdue" if task.due_date < Date.current
    "pending"
  end

  def tab_classes(tab = nil)
    if tab_active?(tab)
      "px-4 py-2 text-indigo-600 border-b-2 bg-indigo-50 border-b-indigo-600 rounded-t"
    else
      "px-4 py-2 text-indigo-600 bg-tansparent border-b-2 border-b-transparent"
    end
  end

  private
    def tab_active?(status = nil)
      return true if request.params[:status] == "all" && status.blank?

      request.params[:status] == status
    end
end
