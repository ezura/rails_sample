class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.integer :document_id
      t.integer :version
      t.text :contents
      t.text :meta

      t.timestamps
    end
  end
end
