# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :user

  validates :name, :due_date, presence: true
end
