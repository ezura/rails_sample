class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.integer :version, :null=>false, :deafult=>0
      t.text :contents
      t.text :meta
      t.text :tmp

      t.timestamps
    end
  end
end
