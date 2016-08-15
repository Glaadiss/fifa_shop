class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.references :account, index: true, foreign_key: true
      t.string :name
      t.integer :overall

      t.timestamps null: false
    end
  end
end
