class AccountMailer < ApplicationMailer
  default from: "fifa16740@gmail.com"

  def confirmation_email(account)
    @account = account

    mail(to: @account.email, subject: 'Potwierdzenie ' )
  end

  def notify_email(account)
    @account = account
    User.all.each do |user|
      mail(to: user.email, subject: 'Nowy klient')
    end
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
