class AddPriorityIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :priority_id, :text
  end
end
