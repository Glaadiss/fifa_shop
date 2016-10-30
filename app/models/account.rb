
class Account < ActiveRecord::Base
  require 'csv'
  include Tokenable
  validates :email, :payment_method, :payment_email,  presence: true
  belongs_to :user
  has_many :players, dependent: :destroy

  def self.to_csv
    attributes = Account.column_names
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |account|
        csv << attributes.map{ |attr| account.send(attr) }
      end
    end
  end
end
