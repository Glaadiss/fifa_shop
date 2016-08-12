class Account < ActiveRecord::Base
  include Tokenable
  validates :email, :payment_method, :payment_email,  presence: true
end
