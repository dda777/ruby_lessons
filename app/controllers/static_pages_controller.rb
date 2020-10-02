class StaticPagesController < ApplicationController
  def home
    @user = current_user
    @project = current_user.projects.build if logged_in?
    @projects = current_user.projects.all
  end

  def help
  end

  def about
  end

  def contact
  end
end
