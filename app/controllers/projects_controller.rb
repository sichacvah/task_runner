class ProjectsController < ApplicationController
  before_action :set_project, except: [:index,:new, :create]

  def index
    @projects = current_user.projects.all
  end

  def edit
    @users = User.all
  end


  def new
    @project = Project.new
    @users = User.all
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to project_tasks_path(@project), notice: "Project succefully created"
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @project.update_attributes(project_params)
        format.html { redirect_to project_path, notice: "change Added" }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:name, :user_ids)
  end

  def set_project
    if current_user.admin?
      @project = Project.find(params[:id])
    else
      @project = current_user.projects.find(params[:id])
    end
  end
end
