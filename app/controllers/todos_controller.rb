class TodosController < ApplicationController
  before_action :set_todo, :only => [:show, :edit, :update, :destroy]
  def index
    @todos = ToDoList.page(params[:page]).per(5)
  end
  
  def show
    @Page_title = @todo.name
  end
  
  def new
    @todo =  ToDoList.new
  end
  
  def create
    @todo = ToDoList.new(todo_params)
    if @todo.save
      redirect_to :action => :index
      flash[:notice] = "The to-do is sucessfully created!"
    else
      render :action => :new
    end
  end
  
  def edit
  end

  def update
    if @todo.update(todo_params)
      redirect_to :action => :show, :id => @todo
      flash[:notice] = "The todo was successfully updated"
    else
      render :action => :edit
    end
  end
  
  def destroy
    @todo.destroy
    redirect_to :action => :index
    flash[:alert] = "You already finish a todo!"
  end
    
  private
  
  def todo_params
    params.require(:to_do_list).permit(:name,:description,:importance)
  end
  
  def set_todo
    @todo = ToDoList.find(params[:id])
  end
  
end
