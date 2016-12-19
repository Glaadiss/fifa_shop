class AccountMailer < ApplicationMailer
  default from: "futaccounts@futaccounts.com"

  def confirmation_email(account)
    @account = account

    mail(to: @account.email, subject: 'Potwierdzenie ' )
  end

  def notify_email(account, to)
    @account = account
    mail(to: to.email, subject: 'Nowy klient')
  end

  def information_email(account)
    @account = account
    mail(to: @account.email, subject: 'Dziękujemy za transakcje' )
  end

  def edit_email(account)
    @account = account

    mail(to: @account.email, subject: 'Pola do poprawy')
  end

  def paid_email(account)
    @account = account
    mail(to: @account.email, subject: 'Środki przesłane')
  end
end
