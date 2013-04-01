class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :name
      t.integer :parent_id
      t.string :file_type
      t.datetime :created_at
      t.integer :size

      t.timestamps
    end
  end
end
