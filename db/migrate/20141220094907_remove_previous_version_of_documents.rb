class RemovePreviousVersionOfDocuments < ActiveRecord::Migration
  def change
    remove_column :documents, :previous_version
  end
end
