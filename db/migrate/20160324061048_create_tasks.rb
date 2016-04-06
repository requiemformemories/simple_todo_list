class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.integer :catergory_id

      t.timestamps null: false
    end
    
    add_index :tasks, :catergory_id
    
  end
end
