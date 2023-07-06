class CategoriesController < ApplicationController
  before_action :find_category, only: [:show, :edit, :destroy]

  def new
    @category = Category.new
  end

  def create
    @new_category = Category.new(post_params)
    @new_category.user = current_user
    if @new_category.save
      redirect_to categories_path, notice: "Category has been created successfully"
    else
      redirect_to new_category_path
    end
  end

  def index
    @categories = Category.all.where(user_id: current_user.id)
  end

  def destroy
    if @category.destroy
      redirect_to  categories_path, notice: "Category has been deleted successfully"
    else
      redirect_to category_path(id: params[:id])
    end
  end

  private

  def post_params
    params.require(:category).permit(:name, :icon)
  end

  private

  def find_category
    @category = Category.find(params[:id])
  end
end
