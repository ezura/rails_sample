class AddDocumentVersionDefaultValue < ActiveRecord::Migration
  def up
    change_table :documents do |t|
      t.change :version, :integer, :deafult => 1, :null => false
    end
  end

  def down
    change_table :products do |t|
      t.change :version, :integer
    end
  end
end
