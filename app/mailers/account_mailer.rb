class AccountMailer < ApplicationMailer
  default from: "fifa16740@gmail.com"

  def confirmation_email(account)
    @account = account

    mail(to: @account.email, subject: 'Potwierdzenie ' )
  end

  def notify_email(account)
    @account = account

    mail(to: User.first.email, subject: 'Nowy klient')
  end

  def information_email(account)
    @account = account

    mail(to: @account.email, subject: 'Dziękujemy transakcje' )
  end

  def edit_email(account)
    @account = account

    mail(to: @account.email, subject: 'Pola do poprawy')
  end
end
