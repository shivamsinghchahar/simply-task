# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :load_tasks, only: [:index]
  before_action :load_task, only: [:edit, :update]

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

  def edit
    render
  end

  def update
    if @task.update(task_params)
      redirect_to root_path, notice: "Successfully updated task"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def task_params
      params.require(:task).permit(:name, :due_date, :is_completed)
    end

    def load_tasks
      status = params[:status]

      @tasks =  case status
                when "overdue"
                  current_user.tasks.overdue
                when "completed"
                  current_user.tasks.completed
                else
                  current_user.tasks
      end
    end

    def load_task
      @task = current_user.tasks.find(params[:id])
    end
end
