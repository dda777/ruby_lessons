class TasksController < ApplicationController
  before_action :find_task!, only: [:update, :prioritize, :complete]
  before_action :find_project!, only: [:create]

  def create
    @task = @project.task.create(task_params)

    if @task.save
      render json: { entry: render_to_string(partial: 'task', locals: { task: @task }), message: 'Задача создана'},
             status: 202

    else
      render json: {errors: @task.errors}, status: 422
    end
  end

  def destroy
    Task.where(id: params[:task][:task_ids]).destroy_all
    render nothing: true, status: 200
  end

  def complete
    @task.update(completed: !@task.completed)

    render nothing: true, status: 200
  end

  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def prioritize
    @task.insert_at(params[:position])

    render nothing: true, status: 200
  end

  private

  def task_params
    params.require(:task).permit(:name, :position)
  end

  def find_task!
    @task = Task.find(params[:id])
  end

  def find_project!
    @project = current_user.projects.find(params[:task][:project_id])
  end
end
