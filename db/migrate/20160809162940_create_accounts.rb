class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :email
      t.string :facebook_or_skype
      t.string :console_type
      t.string :console_email
      t.string :console_password
      t.datetime :console_data
      t.string :web_email
      t.string :web_password
      t.string :web_answer
      t.string :origin_answer
      t.string :origin_email
      t.string :origin_password
      t.string :payment_method
      t.string :payment_email
      t.boolean :confirmed
      t.string :failures
      t.string :token
      t.integer :user_id
      t.string :language

      t.timestamps null: false
    end
  end
end
