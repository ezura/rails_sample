class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.text :resource
      t.integer :revision, :null => false
      t.integer :resource_id, :default => 0, :null => false
      t.timestamps
    end
  end
end
