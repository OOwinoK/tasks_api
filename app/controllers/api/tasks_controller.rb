module Api
  class TasksController < ApplicationController
    before_action :set_task, only: [:destroy]

    def index
      tasks = Task.all
      render json: tasks
    end

    def create
      task = Task.new(task_params)
      if task.save
        render json: task, status: :created
      else
        render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      @task.destroy
      head :no_content
    end

    private

    def set_task
      @task = Task.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Task not found' }, status: :not_found
    end

    def task_params
      params.require(:task).permit(:title, :description, :completed)
    end
  end
end
