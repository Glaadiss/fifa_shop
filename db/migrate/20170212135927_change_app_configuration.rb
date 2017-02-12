class ChangeAppConfiguration < ActiveRecord::Migration
  change_column :app_configurations,:x1_pln, :float
  change_column :app_configurations,:x1_coins,:float
  change_column :app_configurations,:x1_psc, :float
  change_column :app_configurations, :x1_eur, :float
  change_column :app_configurations,:x3_pln, :float
  change_column :app_configurations,:x3_coins, :float
  change_column :app_configurations,:x3_psc, :float
  change_column :app_configurations,:x3_eur, :float
  change_column :app_configurations,:ps4_pln, :float
  change_column :app_configurations,:ps4_coins, :float
  change_column :app_configurations,:ps4_psc, :float
  change_column :app_configurations,:ps4_eur, :float
  change_column :app_configurations,:ps3_pln, :float
  change_column :app_configurations,:ps3_coins, :float
  change_column :app_configurations,:ps3_psc, :float
  change_column :app_configurations, :ps3_eur, :float
end