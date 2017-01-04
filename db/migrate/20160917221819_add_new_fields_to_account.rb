class AddNewFieldsToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :new_fields, :string
  end
end
