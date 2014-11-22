class DropTableVersion < ActiveRecord::Migration
  def change
    drop_table :versions
  end
end
