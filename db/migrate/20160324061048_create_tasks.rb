class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.integer :category_id

      t.timestamps null: false
    end
    
    add_column :tasks, :priority_id, :integer
    add_index :tasks, :category_id
     add_index :tasks, :priority_id
    
  end
end
