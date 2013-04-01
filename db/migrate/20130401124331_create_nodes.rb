class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :name, :null => false
      t.integer :parent_id
      t.string :file_type
      t.string :full_path, :null => false
      t.integer :size, :null => false
      t.string :type

      t.timestamps
    end
  end
end
