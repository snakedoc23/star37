class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :content
      t.string :site
      t.boolean :active

      t.timestamps
    end
  end
end
