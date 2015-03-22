class TasksController < ApplicationController
  before_action :set_project
  before_action :set_task, except: [:index, :new, :create]

  def index
    if params[:tag]
      @tasks = @project.tasks.tagged_with(params[:tag])
    else
      @tasks = @project.tasks.all
    end
  end

  def show
  end

  def new_state
    respond_to do |format|
      @task.send_forward
      format.html { redirect_to project_tasks_path }
      format.json { render json: @task, only: [:aasm_state, :id] }
      format.js
    end
  end

  def previos_state
    respond_to do |format|
      @task.send_back!
      format.html { redirect_to project_tasks_path }
      format.json { render json: @task, only: [:aasm_state, :id] }
      format.js
    end
  end

  def new
    @task = @project.tasks.new
  end

  def create
    @task = @project.tasks.new(task_params.merge(user_id: current_user.id))
    if @task.save
      redirect_to project_tasks_path, notice: "Task succefully created"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update_attributes(task_params)
      redirect_to project_tasks_path, notice: "change added"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to project_tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:title, :estimate, :performer_id, :tag_list)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_task
    @task = @project.tasks.find(params[:id])
  end
end
