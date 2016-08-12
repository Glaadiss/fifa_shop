class AccountsController < ApplicationController

  before_action :authenticate_user!, except: [:new]

  def new
    @account = Account.new
  end

  def index
    @accounts = Account.all.order('created_at DESC')
  end

  def show
    @account = Account.find(params[:token])
  end

  def correction
    @account = Account.find(params[:token])
    @account.update_attributes(failures: params[:account][:failures])
    if @account.failures.present?
      AccountMailer.edit_email(@account).deliver_later
    else
      AccountMailer.information_email(@account).deliver_later
    end
    redirect_to accounts_path
  end

  def edit
    @account = Account.find(params[:token])
  end

  def destroy
    @account = Account.find(params[:id])
    @account.destroy
    redirect_to accounts_path
  end


  def create
    @account = Account.new(account_params)
    if @account.save
      AccountMailer.confirmation_email(@account).deliver_later
      AccountMailer.notify_email(@account).deliver_later
      redirect_to home_path, notice: 'Pomyślnie wypełniono formularz, sprawdź skrzynkę pocztową'
    else
      render 'new', alert: 'Wypełnij jeszcze raz :('
    end

  end

  private

  def account_params
    params.require(:account).permit(:email, :twitter, :skype, :console_type, :console_email, :console_password, :web_email, :web_password, :web_answer, :origin_answer, :origin_email, :origin_password, :payment_method, :payment_email)
  end
end
