# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks, id: :uuid do |t|
      t.text :name, null: false
      t.date :due_date, null: false
      t.boolean :is_completed, null: false, default: false
      t.belongs_to :user, index: true, null: false, foreign_key: { on_delete: :cascade }, type: :uuid

      t.timestamps
    end
  end
end
