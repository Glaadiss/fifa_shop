class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :accounts
  scope :accounts_count, -> {accounts.where(confirmed: true).count}
  scope :accounts_count_in_month, -> {accounts.where(confirmed: true, updated_at: Date.today.at_beginning_of_month..Date.today).count }
end
