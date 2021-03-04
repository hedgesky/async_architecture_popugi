class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  def index
    @tasks = Task.order(created_at: :desc)
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

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: "Task was successfully destroyed."
  end

  def assign
    AssignOpenTasks.new.call

    redirect_to tasks_url, notice: "All open tasks were assigned"
  end

  def my
    if current_user
      @tasks = FetchUserTasks.new(current_user).call
      render :index
    else
      redirect_to tasks_url, alert: 'Use user_id query param to authenticate'
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:description, :state, :assignee_id)
  end
end
