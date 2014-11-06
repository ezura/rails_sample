class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.text :content
      t.integer :version
      t.text :meta_info

      t.timestamps
    end
  end
end
