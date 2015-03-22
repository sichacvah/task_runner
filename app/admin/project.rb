ActiveAdmin.register Project do
  permit_params :name, user_attributes: [:id, :email], user_ids: [:id]

  index do
    selectable_column
    id_column
    column :name
    actions
  end

  form do |f|
    f.input :name
    f.input :users, as: :check_boxes, multiple: true, member_label: :email
    f.submit
  end

  show do
    panel "Project" do
      h3 "ID - #{project.id}"
      h3 "Name - #{project.name}"
      table_for project.users do
        column :id
        column :email
      end
    end
  end

  controller do
    def new
      @project = Project.new
    end
    
    def create
      @project = Project.new
      @project.name = params[:project][:name]
      users = params[:project][:user_ids]
      users.shift
      users.each do |user|
        @project.users << User.find(user.to_i)
      end
      if @project.save
        redirect_to resource_path(@project)
      else
        render "new"
      end
    end

    def update
      project = Project.find(params[:id])
      project.users.delete_all
      users = params[:project][:user_ids]
      users.shift
      users.each do |user|
        project.users << User.find(user.to_i)
      end
      if project.update_attributes(name: params[:project][:name])
        redirect_to resource_path(project)
      else
        render "edit"
      end
    end
  end
end
