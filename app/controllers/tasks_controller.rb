class TasksController < ApplicationController
  before_action :set_task, :only => [:show, :edit, :update, :destroy]
  def index
    @categories = Category.all
    
    if params[:keyword]
      @tasks = Task.where( [ "name like ?", "%#{params[:keyword]}%" ] ).page(params[:page]).per(5)
      @Page_title = "Search: " + params[:keyword] 
    else
      case params[:status] 
      when 'finished'
        @tasks = Task.where(is_finished: TRUE).page(params[:page]).per(5)
        @Page_title = "To-do List: Finished"
      when 'unfinish'
        @tasks = Task.where(is_finished: FALSE).page(params[:page]).per(5)
        @Page_title = "To-do List: Unfinish"
      when 'high-priority'
        @tasks = Task.where(priority_id: 1).page(params[:page]).per(5)
        @Page_title = "To-do List: High Priority"
      when 'normal-priority'  
        @tasks = Task.where(priority_id: 2).page(params[:page]).per(5)
        @Page_title = "To-do List: Normal Priority"
      when 'low-priority'
        @tasks = Task.where(priority_id: 3).page(params[:page]).per(5)
        @Page_title = "To-do List: Low Priority"
      else
        @tasks = Task.page(params[:page]).per(5)
        @Page_title = "To-do List"
        @categories.each do |category|
          if params[:status] == category.name
            @tasks = Task.where(category_id: category.id).page(params[:page]).per(5)
            @Page_title = "To-do List: " + category.name
          end
        end
      end
    end  
  end
  
  def show
    @Page_title = @task.name
  end
  
  
  def new
    @task =  Task.new
  end
  
  def create
    @task = Task.new(task_params)
    @task.is_finished = false
    if @task.save
      redirect_to tasks_url
      flash[:notice] = "The task was sucessfully created!"
    else
      render :action => :new
    end
  end
  
  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to task_url(@task)
      flash[:notice] = "The task was successfully updated"
    else
      render :action => :edit
    end
  end
  
  def finish
    @task = Task.find(params[:id])
    @task.update(:is_finished => true)
    @task.save
    redirect_to tasks_url
    flash[:notice] = "You finished a tasks!"
  end
  
  def destroy
    @task.destroy
    redirect_to tasks_url
    flash[:alert] = "You deleted a task!"
  end
    
  private
  
  def task_params
    params.require(:task).permit(:name, :description, :priority_id, :category_id, :is_finished)
  end
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  
end
