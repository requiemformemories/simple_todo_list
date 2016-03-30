class ChangePriorityId < ActiveRecord::Migration
  def change
    change_column :tasks, :priority_id, :integer
  end
end
