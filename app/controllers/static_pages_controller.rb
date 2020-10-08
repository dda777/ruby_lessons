class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @project = current_user.projects.build
      @projects = Project.includes(:task).where(user_id: current_user.id)

    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
