class ProjectsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :update]

  def create
    @project = current_user.projects.build(projects_params)
    if @project.save
      flash[:success] = 'Project created!'
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def update

  end

  def destroy
    Project.find(params[:id]).destroy
    flash[:success] = 'Project deleted'
    redirect_to root_url
  end

  private
  def projects_params
    params.require(:project).permit(:title)
  end
end
