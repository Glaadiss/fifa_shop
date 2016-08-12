class AccountMailer < ApplicationMailer
  def confirmation(account)
    @account = account

    mail(to: @account.email )
  end

  def notify_email(account)
    @account = account

    mail(to: User.first.email )
  end

  def information_email(account)
    @account = account

    mail(to: @account.email )
  end

  def edit_email(account)
    @account = account

    mail(to: @account.email)
  end
end
