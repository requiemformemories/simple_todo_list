class ChangePriorityId < ActiveRecord::Migration
  def change
    add_column :tasks, :priority_id, :integer
    add_index :tasks, :priority_id
  end
end
