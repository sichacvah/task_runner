class User < ActiveRecord::Base
  rolify
  after_create :assign_default_role

  has_many :tasks, dependent: :destroy
  has_and_belongs_to_many :projects, join_table: :users_projects


  validates :password, presence: true,
                       confirmation: true,
                       length: { minimum: 3 },
                       on: [:create, :update],
                       allow_nil: true
  validates :email, presence: true, uniqueness: true
  validates :password_confirmation,presence: true,
                                   on: [:create, :update],
                                   allow_nil: true


  authenticates_with_sorcery!

  def assign_default_role
    add_role :user
  end

  def admin?
    has_role? :admin
  end
end
