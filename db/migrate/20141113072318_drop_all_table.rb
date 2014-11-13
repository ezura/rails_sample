class DropAllTable < ActiveRecord::Migration
  def change
    drop_table :documents
    drop_table :slides
    drop_table :versions
  end
end
