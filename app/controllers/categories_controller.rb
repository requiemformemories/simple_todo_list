class CategoriesController < ApplicationController
  before_action :set_category, :only => [:show, :edit, :update, :destroy]
  def index
    @categories = Category.page(params[:page]).per(5)
  end
  def new
    @category =  Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_url
      flash[:notice] = "The category was sucessfully created!"
    else
      render :action => :new
    end
  end
  
  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to categories_url
      flash[:notice] = "The category was successfully updated"
    else
      render :action => :edit
    end
  end
  
  def destroy
    @category.destroy
    redirect_to categories_url
    flash[:alert] = "You deleted a category!"
  end
    
  private
  
  def category_params
    params.require(:category).permit(:name)
  end
  
  def set_category
    @category = Category.find(params[:id])
  end
  
end
