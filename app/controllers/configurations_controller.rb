class ConfigurationsController < ApplicationController

  before_action :authenticate_user!
  before_action :admin_authenticate

  def edit
    @config = AppConfiguration.first
  end

  def update
    @config = AppConfiguration.first
    @config.update_attributes(config_params)
    @config.update_attributes(work?: params[:app_configuration][:work])
    redirect_to root_path, notice: 'Zmieniono konfiguracje serwera'
  end

  def emails
    @emails = Email.order('created_at DESC')
  end

  def delete_email
    email = Email.find(params[:id])
    email.destroy
    redirect_to '/emails'
  end

  def create_emails
    emails = params[:emails].split(' ').map{|k| k.split(':')}
    emails.each { |em| Email.create(name: em[0], password: em[1] ) }
    redirect_to '/emails'
  end

  def admin_authenticate
    redirect_to root_path unless current_user.role == 2
  end

  private

  def config_params
    params.require(:app_configuration).permit(:x1_pln, :x1_coins, :x1_psc, :x1_eur, :x3_pln, :x3_coins, :x3_psc, :x3_eur, :ps4_pln, :ps4_coins, :ps4_psc, :ps4_eur, :ps3_pln, :ps3_coins, :ps3_psc, :ps3_eur)
  end

end
