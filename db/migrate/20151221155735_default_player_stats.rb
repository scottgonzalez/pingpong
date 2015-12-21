class DefaultPlayerStats < ActiveRecord::Migration
  def change
  	change_column :players, :wins, :integer, :default => 0
  	change_column :players, :losses, :integer, :default => 0
  end
end
