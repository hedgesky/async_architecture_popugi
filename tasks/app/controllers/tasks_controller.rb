class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy complete ]

  def index
    @tasks = Task.open.order(created_at: :desc).includes(:assignee)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    result, @task = CreateTask.new(attributes: task_params).call

    if result
      redirect_to @task, notice: "Task was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if UpdateTask.new(task: @task, attributes: task_params).call
      redirect_to @task, notice: "Task was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def complete
    CompleteTask.new(task: @task).call
    redirect_to my_tasks_url, notice: "Task marked as done"
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: "Task was successfully destroyed."
  end

  def assign
    AssignOpenTasks.new.call

    redirect_to tasks_url, notice: "All open tasks were assigned"
  end

  def my
    if current_account
      @tasks = FetchUserTasks.new(current_account).call.includes(:assignee)
    else
      redirect_to tasks_url, alert: 'Use user_id query param to authenticate'
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:description)
  end
end
