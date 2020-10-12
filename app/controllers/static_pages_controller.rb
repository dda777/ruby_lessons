class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @project = Project.new
      @projects = current_user.projects.page(params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
