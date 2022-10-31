# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :load_tasks, only: [:index]

  def index
    render
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      redirect_to root_path, notice: "Successfully added task"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def task_params
      params.require(:task).permit(:name, :due_date, :is_completed)
    end

    def load_tasks
      @tasks = current_user.tasks
    end
end
