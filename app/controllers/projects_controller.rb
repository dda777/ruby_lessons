class ProjectsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :update]
  before_action :project?, only: [:update, :destroy]

  def create
    @project = current_user.projects.create(project_params)

    if @project.save
      render json: { entry: render_to_string(partial: 'project', locals: { project: @project }), message: 'Проэкт успешно обновлен' },
             status: 202
    else
      render json: { errors: @project.errors }, status: 422
    end
  end

  def update
    if @project.update(project_params)
      render json: @project
    else
      render text: @project.errors.full_messages.join("<br />")
    end

  end

  def destroy
    @project.destroy
    render json: { message: 'Проэкт успешно удален' }, status: 200
  end

  private
  def project_params
    params.require(:project).permit(:title)
  end

  def project?
    @project = current_user.projects.find(params[:id])
  end
end
