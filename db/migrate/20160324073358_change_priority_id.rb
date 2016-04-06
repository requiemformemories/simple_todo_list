class ChangePriorityId < ActiveRecord::Migration
  def change
    change_column :tasks, :priority_id, :integer
    add_index :tasks, :priority_id
  end
end
