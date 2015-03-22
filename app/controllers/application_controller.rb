class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login, except: [:not_authenticated]

  def not_authenticated
    flash[:danger] = "Need login!"
    redirect_to root_path
  end
end
