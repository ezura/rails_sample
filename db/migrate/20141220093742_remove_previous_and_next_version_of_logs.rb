class RemovePreviousAndNextVersionOfLogs < ActiveRecord::Migration
  def change
    remove_column :logs, :previous_version
    remove_column :logs, :next_version
  end
end
