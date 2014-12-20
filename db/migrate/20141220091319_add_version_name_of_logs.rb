class AddVersionNameOfLogs < ActiveRecord::Migration
  def change
    add_column :logs, :version_name, :string, :unique => true
    add_index :logs, :version_name
  end
end
