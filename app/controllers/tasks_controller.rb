class TasksController < ApplicationController
  before_action :set_task, :only => [:show, :edit, :update, :destroy]
  
  def index
    @categories = Category.all

    
    if params[:keyword]
      @tasks = Task.where( [ "name like ?", "%#{params[:keyword]}%" ] )
      @Page_title = "Search: " + params[:keyword] 
    else
      case params[:status] 
      when 'finished'
        @tasks = Task.where(is_finished: TRUE)
        @Page_title = "To-do List: Finished"
      when 'unfinish'
        @tasks = Task.where(is_finished: FALSE)
        @Page_title = "To-do List: Unfinish"
      when 'high-priority'
        @tasks = Task.where(priority_id: 1)
        @Page_title = "To-do List: High Priority"
      when 'normal-priority'  
        @tasks = Task.where(priority_id: 2)
        @Page_title = "To-do List: Normal Priority"
      when 'low-priority'
        @tasks = Task.where(priority_id: 3)
        @Page_title = "To-do List: Low Priority"
      else
        @tasks = Task.all
        @Page_title = "To-do List"
        @categories.each do |category|
          if params[:status] == category.name
            @tasks = Task.where(category_id: category.id).page(params[:page]).per(5)
            @Page_title = "To-do List: " + category.name
          end
        end
      end
    end
    respond_to do |format|
      format.html { }
      format.js {  }
    end
  end
  
  
  def show
    respond_to do |format|
      format.js {  }
    end
  end
  
  
  def new
    @task = Task.new
    respond_to do |format|
      format.js {  }
    end
  end
  
  def create
    @categories = Category.all
    @tasks = Task.all
    @task = Task.create(task_params)
    @task.is_finished = false
    respond_to do |format|
      if @task.save
        flash[:notice] = "The task was successfully created"
        format.html { redirect_to tasks_url }
        format.js
      else
        format.html {}
        format.js{render :template => 'tasks/formerror.js.erb'}
    end
    end
  end
  
  def edit
    respond_to do |format|
      format.js {  }
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        flash[:notice] = "The task was successfully updated"
        format.html { redirect_to tasks_url }
        format.js
      else
        format.html {}
      end
    end  
  end
  
  def finish
    @task = Task.find(params[:id])
    @task.update(:is_finished => true)
    @task.save
    respond_to do |format|
      flash[:notice] = "You finished a task!"
      format.html { redirect_to tasks_url }
      format.js { }
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy  
    respond_to do |format|
      flash[:alert] = "You deleted a task!"
      format.html { redirect_to tasks_url }
      format.js { }
    end
  end

    
  private
  
  def task_params
    params.require(:task).permit(:name, :description, :priority_id, :category_id, :is_finished)
  end
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  
end
