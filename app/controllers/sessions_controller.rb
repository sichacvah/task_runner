class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    if @user = login(session_params[:email], session_params[:password])
      redirect_to projects_path, notice: "Login successful"
    else
      flash.now[:alert] = "Login failed"
      render action: "new"
    end
  end

  def destroy
    logout
    flash[:success] = "Logged out!"
    redirect_to root_url
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end