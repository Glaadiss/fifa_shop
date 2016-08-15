class AccountsController < ApplicationController

  before_action :authenticate_user!, except: [:new, :create, :edit, :update]

  def new
    @account = Account.new
  end

  def index
    @accounts = Account.all.order('created_at DESC')
  end

  def show
    @account = Account.find_by_token(params[:id])
  end

  def correction
    @account = Account.find_by_token(params[:account_id])
    failures = params[:account].to_a.select{ |par,val| val!='0'}.join(',')
    @account.update_attributes(failures: failures, user_id: current_user.id)
    if @account.failures.present?
      AccountMailer.edit_email(@account).deliver
    else
      @account.update_attributes(confirmed: true)
      AccountMailer.information_email(@account).deliver
    end
    redirect_to accounts_path
  end

  def edit
    @account = Account.find_by_token(params[:id])
  end

  def destroy
    @account = Account.find_by_token(params[:id])
    @account.destroy
    redirect_to accounts_path
  end


  def create
    @account = Account.new(account_params)
    @account.language = session[:locale]
    if @account.save
      AccountMailer.confirmation_email(@account).deliver
      AccountMailer.notify_email(@account).deliver
      redirect_to root_path, notice: 'Pomyślnie wypełniono formularz, sprawdź skrzynkę pocztową'
    else
      render 'new', alert: 'Wypełnij jeszcze raz :('
    end

  end

  private

  def account_params
    params.require(:account).permit(:email, :twitter, :skype, :console_type, :console_email, :console_password, :web_email, :web_password, :web_answer, :origin_answer, :origin_email, :origin_password, :payment_method, :payment_email)
  end
end
