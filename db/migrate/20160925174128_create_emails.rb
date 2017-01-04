class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :name
      t.string :password
      t.boolean :complete?

      t.timestamps null: false
    end
  end
end
