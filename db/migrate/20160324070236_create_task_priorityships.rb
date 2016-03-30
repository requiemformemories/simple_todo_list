class CreateTaskPriorityships < ActiveRecord::Migration
  def change
    create_table :task_priorityships do |t|
      t.integer :task_id
      t.integer :priority_id

      t.timestamps null: false
    end
    
    drop_table  :task_priorityships
    
    
  end
end
