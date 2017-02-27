class CreateBlockedIps < ActiveRecord::Migration
  def change
    create_table :blocked_ips do |t|
      t.string :ip
      t.string :name
      t.string :descrption
      t.timestamps null: false
    end
  end
end
