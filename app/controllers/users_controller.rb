class UsersController  < ApplicationController

  before_action :authenticate_user!
  before_action :admin_authenticate

  def index
    @users = User.all
  end

  def admin_authenticate
    redirect_to root_path unless current_user.role == 2
  end


end
