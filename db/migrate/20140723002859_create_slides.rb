class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.string:diff
      t.timestamps
    end
  end
end
