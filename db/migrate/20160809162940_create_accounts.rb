class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :email
      t.string :skype
      t.string :twitter
      t.string :console_type
      t.string :console_email
      t.string :console_password
      t.string :web_email
      t.string :web_password
      t.text :web_answer
      t.text :origin_answer
      t.string :origin_email
      t.string :origin_password
      t.string :payment_method
      t.string :payment_email
      t.boolean :confirmed

      t.timestamps null: false
    end
  end
end
