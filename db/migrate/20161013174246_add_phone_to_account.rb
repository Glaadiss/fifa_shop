class AddPhoneToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :phone, :string
    add_column :accounts, :recommend, :string
  end
end
