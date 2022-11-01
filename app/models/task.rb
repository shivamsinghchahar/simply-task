# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :user

  validates :name, :due_date, presence: true

  scope :completed, -> { where(is_completed: true) }
  scope :overdue,   -> { where(due_date: ...Date.current, is_completed: false) }
end
