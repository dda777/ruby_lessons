class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @projects = current_user.projects.page(params[:page])
      @project = Project.new
    end
  end

  def privacy
  end

  def datetime
    @task = Task.new
  end
end
