class AddIpToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :ip, :string
  end
end
