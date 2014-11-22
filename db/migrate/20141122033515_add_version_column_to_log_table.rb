class AddVersionColumnToLogTable < ActiveRecord::Migration
  def change
    add_column :documents, :version, :integer, default: 0
  end
end
