class UserssController  < ApplicationController

  before_action :authenticate_user!
  before_action :admin_authenticate

  def index
    @users = User.all
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if params[:user][:password] == params[:user][:password_confirmation] && @user.save
      redirect_to root_path, notice: 'User stworzony pomyślnie'
    else
      render 'new', alert: 'Złe dane'
    end
  end

  def admin_authenticate
    redirect_to root_path unless current_user.role == 2
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end


end
