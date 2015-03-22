class ChangeTaskStateController < ApplicationController
  before_action :set_project
  before_action :set_task

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_task
    @task = @project.tasks.find(params[:id])
  end
end
