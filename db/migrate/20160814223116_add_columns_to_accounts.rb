class AddColumnsToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :user_id, :integer
    add_column :accounts, :language, :string
  end
end
