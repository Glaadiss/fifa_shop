class AccountsController < ApplicationController

  before_action :authenticate_user!, except: [:new]

  def new
    @account = Account.new
  end

  def index
    @accounts = Account.all.order('created_at DESC')
  end

  def show
    @account = Account.find(params[:id])
  end

  def destroy
    @account = Account.find(params[:id])
    @account.destroy
    redirect_to accounts_path
  end


  def create
    @account = Account.new(account_params)
    if @account.save

      redirect_to home_path
    else
      render 'new'
    end

  end

  private

  def account_params
    params.require(:account).permit(:email, :twitter, :skype, :console_type, :console_email, :console_password, :web_email, :web_password, :web_answer, :origin_answer, :origin_email, :origin_password, :payment_method, :payment_email)
  end
end
