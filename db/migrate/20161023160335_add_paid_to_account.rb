class AddPaidToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :paid?, :boolean
  end
end
