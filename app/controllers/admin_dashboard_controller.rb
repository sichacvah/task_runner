class AdminDashboardController < ApplicationController
  def index
    @projects = Project.all
  end
end
