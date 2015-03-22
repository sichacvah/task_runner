class Project < ActiveRecord::Base
  validates :name, presence: true
  has_many :tasks, dependent: :destroy
  has_and_belongs_to_many :users, join_table: :users_projects
end
