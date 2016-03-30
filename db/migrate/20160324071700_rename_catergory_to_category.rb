class RenameCatergoryToCategory < ActiveRecord::Migration
  def change
    rename_column :tasks, :catergory_id, :category_id 
  end
end
