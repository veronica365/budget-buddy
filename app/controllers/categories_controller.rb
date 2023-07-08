class CategoriesController < ApplicationController
  before_action :find_category, only: [:edit, :update, :destroy]

  def new
    @category = Category.new
  end

  def create
    @new_category = Category.new(category_params)
    @new_category.user = current_user
    if @new_category.save
      redirect_to categories_path, notice: "Category has been created successfully"
    else
      redirect_to new_category_path
    end
  end

  def index
    @categories = Category.find_by_sql("SELECT DISTINCT categories.id, categories.name, categories.icon, categories.created_at, SUM(transactions.amount) AS amount
    FROM \"categories\"
    LEFT JOIN transactions ON transactions.category_id = categories.id
    WHERE \"categories\".\"user_id\" = #{current_user.id}
      GROUP BY categories.id, categories.name")
  end

  def destroy
    if @category.destroy
      redirect_to  categories_path, notice: "Category has been deleted successfully"
    else
      redirect_to categories_path
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to categories_url, notice: 'Category was successfully updated.'
    else
        render :edit, status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end

  private

  def find_category
    @category = Category.includes(:transactions).find(@category_id)
  end
end
