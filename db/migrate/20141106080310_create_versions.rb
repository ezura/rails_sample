class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.integer :document_id
      t.text :content
      t.integer :commit_id

      t.timestamps
    end
  end
end
