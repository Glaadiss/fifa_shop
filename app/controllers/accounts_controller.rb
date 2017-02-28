class AccountsController < ApplicationController

  before_action :authenticate_user!, except: [:new, :create, :edit, :update, :regulations, :contact]

  def regulations
  end
  def contact
  end

  def generate
    @accounts = params[:green] ? Account.where(confirmed: true) : Account.all
    respond_to do |format|
      format.csv { send_data @accounts.to_csv, filename: "accounts-#{Date.today}.csv" }
    end
  end

  def delete_between
    from_obj = { y: params[:from][6..9], m: params[:from][0..1], d: params[:from][3..4] }
    to_obj = { y: params[:to][6..9], m: params[:to][0..1], d: params[:to][3..4] }
    begin
      from = Time.new(from_obj[:y], from_obj[:m], from_obj[:d] )
      to = Time.new(to_obj[:y], to_obj[:m], to_obj[:d] )
      Account.where(updated_at: from..to).destroy_all
    rescue Exception => msg
      puts msg
    end
    redirect_to accounts_path
  end

  def new
    @account = Account.new
    @config = AppConfiguration.first
  end

  def index
    if params[:failures]
      @accounts = Account.where.not(failures: nil).where(confirmed: nil).order('updated_at DESC')
    elsif params[:confirmed]
      @accounts = Account.where(confirmed: params[:confirmed], paid?: params[:paid]).order('updated_at DESC')
    elsif params[:type]
      @accounts = Account.where(confirmed: nil, failures: nil).order('updated_at DESC')
    else
      @accounts = Account.all.order('updated_at DESC')
    end
  end

  def show
    @config = AppConfiguration.first
    @account = Account.find_by_token(params[:id])
  end

  def correction
    pl_keys = ["id", "email", "facebook lub skype", "typ konsoli", "email konsoli", "hasło konsoli", "data urodzenia na konsoli", "web-app email",
              "hasło web-app", "odpowiedź na pytanie web-app", "odpowiedź na pytanie origin", "adres email", "hasło email", "metoda płatności",
              "email do płatnośći", "confirmed", "failures", "token", "user_id", "language", "created_at", "updated_at", 'Numer telefonu', 'Polecony przez']
    @account = Account.find_by_token(params[:account_id])
    new_fields = params[:new_fields].each_slice(2).map{|k| [k[0] + k[1]] }.join(' | ').sub('Hasło do Origin:', 'Hasło do email z Origin:')
    new_fields += " | rekomendacja: #{@account.try(:recommend)}" if new_fields.present?
    market_error = ',Transfer market locked' if params[:market]
    market_error = ',Rynek zablokowany' if market_error && @account.language == 'pl'
    other_failure = ",#{params[:other_failure]}" if params[:other_failure]
    keys = @account.attributes.keys
    pl_hash = Hash[keys.zip(pl_keys)]
    failures = params[:account].to_a.select{ |par,val| val==par }.join(',')
    failures = failures.split(',').map{|k| pl_hash[k] }.join(',') if @account.language == 'pl'
    failures += market_error if market_error.present?
    failures += other_failure if other_failure.present?
    failures.gsub!('origin_password', 'password to email from origin')
    @account.update_attributes(failures: failures, user_id: current_user.id, new_fields: new_fields)
    if @account.failures.present? && @account.failures != ','
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

  def get_email
    @email = Email.where(complete?: nil).first
    @email.update(complete?: true) if @email.present?
    respond_to do |f|
      f.json { render json: @email }
    end
  end

  def create
    @config = AppConfiguration.first
    @account = Account.new(account_params)
    @account.language = session[:locale]
    blocked_ip= BlockedIp.where(ip: @account.ip).exists?
    # verify_recaptcha(model: @account) &&
    if @account.save && !blocked_ip
      if params[:players].present?
        players = params[:players].values.zip(params[:overalls].values)
        players.each do |player|
          Player.create(account_id: @account.id, name: player[0], overall: player[1])
        end
      end
      if AppConfiguration.first.work?
        AccountMailer.confirmation_email(@account).deliver_later
        User.all.each do |usr|
          AccountMailer.notify_email(@account, usr).deliver_later
        end
      end
      redirect_to root_path, notice: 'Pomyślnie wypełniono formularz, sprawdź skrzynkę pocztową'
    else
      render 'new', alert: 'Wypełnij jeszcze raz :('
    end

  end

  def update
    @config = AppConfiguration.first
    @account = Account.find_by_token(params[:account][:token])
    @account.update_attributes(failures: nil)
    if @account.update_attributes(account_params)
      @account.players.destroy_all if @account.players.any?
      if params[:players].present?
        players = params[:players].values.zip(params[:overalls].values)
        players.each do |player|
          Player.create(account_id: @account.id, name: player[0], overall: player[1])
        end
      end
      if AppConfiguration.first.work?
        AccountMailer.confirmation_email(@account).deliver_later
        User.all.each do |usr|
          AccountMailer.notify_email(@account, usr).deliver_later
        end
      end
      redirect_to root_path, notice: 'Pomyślnie wypełniono formularz, sprawdź skrzynkę pocztową'
    else
      render 'edit', alert: 'Wypełnij jeszcze raz :('
    end
  end

  def paid
    @config = AppConfiguration.first
    @account = Account.find(params[:id])
    @account.update(paid?: true)
    if AppConfiguration.first.work?
      AccountMailer.paid_email(@account).deliver_later
    end
    redirect_to root_path
  end

  private

  def account_params
    params.require(:account).permit(:email, :facebook_or_skype, :console_type, :console_email, :console_password, :console_data, :web_email, :web_password, :web_answer, :origin_answer, :origin_email, :origin_password, :payment_method, :payment_email, :phone, :recommend)
  end
end
