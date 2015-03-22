ActiveAdmin.setup do |config|
  config.site_title = "Task Runner"
  config.site_title_link = :root
  config.authentication_method = :authenticate_admin!

  def authenticate_admin!
    redirect_to root_path unless current_user.admin?
  end

  config.logout_link_path = :destroy_admin_user_session_path

  config.batch_actions = true
end
