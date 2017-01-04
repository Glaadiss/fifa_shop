# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  before_action :user_exist
  def new
    super
  end

  def create
    super
  end

  def update
    super
  end

  def user_exist
    redirect_to root_path unless current_user
  end
end
