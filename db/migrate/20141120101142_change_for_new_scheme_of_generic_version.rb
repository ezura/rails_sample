class ChangeForNewSchemeOfGenericVersion < ActiveRecord::Migration
  def change
    rename_column :documents, :version, :previous_version
  end
end
