class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :name
      t.integer :parent_id
      t.string :file_type
      t.string :full_path
      t.integer :size
      t.string :type

      t.timestamps
    end
  end
end
