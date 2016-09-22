class AccountsController < ApplicationController

  before_action :authenticate_user!, except: [:new, :create, :edit, :update, :regulations, :contact]

  def regulations
  end
  def contact
  end

  def new
    @account = Account.new
    @config = AppConfiguration.first
  end

  def index
    @accounts = Account.all.order('created_at DESC')
  end

  def show
    @config = AppConfiguration.first
    @account = Account.find_by_token(params[:id])
  end

  def correction
    pl_keys = ["id", "email", "facebook lub skype", "typ konsoli", "email konsoli", "hasło konsoli", "data urodzenia na konsoli", "web-app email",
              "hasło web-app", "odpowiedź na pytanie web-app", "odpowiedź na pytanie origin", "email origin", "origin hasło", "metoda płatności",
              "email do płatnośći", "confirmed", "failures", "token", "user_id", "language", "created_at", "updated_at"]
    new_fields = params[:new_fields].each_slice(2).map{|k| [k[0] + k[1]] }.join(' | ')
    @account = Account.find_by_token(params[:account_id])
    keys = @account.attributes.keys
    pl_hash = Hash[keys.zip(pl_keys)]
    failures = params[:account].to_a.select{ |par,val| val==par }.join(',')
    failures = failures.split(',').map{|k| pl_hash[k] }.join(',') if @account.language == 'pl'
    @account.update_attributes(failures: failures, user_id: current_user.id, new_fields: new_fields)
    if @account.failures.present?
      AccountMailer.edit_email(@account).deliver_later if AppConfiguration.first.work?
    else
      @account.update_attributes(confirmed: true)
      AccountMailer.information_email(@account).deliver_later if AppConfiguration.first.work?
    end
    redirect_to accounts_path
  end

  def edit
    @config = AppConfiguration.first
    @account = Account.find_by_token(params[:id])
  end

  def destroy
    @account = Account.find_by_token(params[:id])
    @account.destroy
    redirect_to accounts_path
  end


  def create
    @config = AppConfiguration.first
    @account = Account.new(account_params)
    @account.language = session[:locale]
    if verify_recaptcha(model: @account) && @account.save
      if params[:players].present?
        players = params[:players].values.zip(params[:overalls].values)
        players.each do |player|
          Player.create(account_id: @account.id, name: player[0], overall: player[1])
        end
      end
      if AppConfiguration.first.work?
        AccountMailer.confirmation_email(@account).deliver_later
        AccountMailer.notify_email(@account).deliver_later
      end
      redirect_to root_path, notice: 'Pomyślnie wypełniono formularz, sprawdź skrzynkę pocztową'
    else
      render 'new', alert: 'Wypełnij jeszcze raz :('
    end

  end

  def update
    @config = AppConfiguration.first
    @account = Account.find_by_token(params[:account][:token])
    if verify_recaptcha(model: @account) && @account.update_attributes(account_params)
      @account.players.destroy_all if @account.players.any?
      if params[:players].present?
        players = params[:players].values.zip(params[:overalls].values)
        players.each do |player|
          Player.create(account_id: @account.id, name: player[0], overall: player[1])
        end
      end
      if AppConfiguration.first.work?
        AccountMailer.confirmation_email(@account).deliver_later
        AccountMailer.notify_email(@account).deliver_later
      end
      redirect_to root_path, notice: 'Pomyślnie wypełniono formularz, sprawdź skrzynkę pocztową'
    else
      render 'edit', alert: 'Wypełnij jeszcze raz :('
    end
  end

  def paid
    @config = AppConfiguration.first
    @account = Account.find(params[:id])
    if AppConfiguration.first.work?
      AccountMailer.paid_email(@account).deliver_later
    end
    redirect_to root_path
  end

  private

  def account_params
    params.require(:account).permit(:email, :facebook_or_skype, :console_type, :console_email, :console_password, :console_data, :web_email, :web_password, :web_answer, :origin_answer, :origin_email, :origin_password, :payment_method, :payment_email)
  end
end
