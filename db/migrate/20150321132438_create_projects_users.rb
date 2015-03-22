class CreateProjectsUsers < ActiveRecord::Migration
  def change
    create_table :users_projects, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :project, index: true

      t.timestamps null: false
    end
  end
end
