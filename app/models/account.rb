class Account < ActiveRecord::Base
  include Tokenable
  validates :email, :payment_method, :payment_email,  presence: true
  belongs_to :user
  has_many :players
end
