class AddIsFinishedToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :is_finished, :boolean
  end
end
