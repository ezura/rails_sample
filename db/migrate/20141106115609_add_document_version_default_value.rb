class AddDocumentVersionDefaultValue < ActiveRecord::Migration
  def up
    change_table :documents do |t|
      t.change :version, :integer, :default => 0, :null => false
    end
  end

  def down
    change_table :documents do |t|
      t.change :version, :integer
    end
  end
end
