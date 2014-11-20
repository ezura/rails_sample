class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :document_id, null: false
      t.integer :version, null: false
      t.text :contents
      t.text :meta
      t.integer :previous_version, null: false
      t.integer :next_version, null: false

      t.timestamps
    end
  end
end
