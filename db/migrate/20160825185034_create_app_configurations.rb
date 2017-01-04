class CreateAppConfigurations < ActiveRecord::Migration
  def change
    create_table :app_configurations do |t|
      t.boolean :work?, default: false
      t.integer :x1_pln, default: 20
      t.integer :x1_coins, default: 50000
      t.integer :x1_psc, default: 20
      t.integer :x1_eur, default: 5
      t.integer :x3_pln, default: 10
      t.integer :x3_coins, default: 20000
      t.integer :x3_psc, default: 10
      t.integer :x3_eur, default: 3
      t.integer :ps4_pln, default: 20
      t.integer :ps4_coins, default: 50000
      t.integer :ps4_psc, default: 20
      t.integer :ps4_eur, default: 5
      t.integer :ps3_pln, default: 10
      t.integer :ps3_coins, default: 10000
      t.integer :ps3_psc, default: 5
      t.integer :ps3_eur, default: 4

      t.timestamps null: false
    end
  end
end
