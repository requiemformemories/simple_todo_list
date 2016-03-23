class TodosController < ApplicationController
  def index
    @todos = ToDoList.all
  end
end
