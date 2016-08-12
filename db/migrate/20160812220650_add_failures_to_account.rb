class AddFailuresToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :failures, :string
  end
end
