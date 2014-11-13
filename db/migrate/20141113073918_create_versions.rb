class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.integer :document_id, :null=>false
      t.integer :version, :null=>false
      t.text :contents
      t.text :meta

      t.timestamps
    end
  end
end
