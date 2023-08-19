class CategoriesController < ApplicationController
  # This is same as laad_and_authorize_resource but lighter
  check_authorization
  skip_authorization_check

  before_action :find_category, only: %i[edit update destroy]

  def new
    @category = Category.new
  end

  def create
    @new_category = Category.new(category_params)
    @new_category.user = current_user
    if @new_category.save
      redirect_to categories_path, notice: 'Category has been created successfully'
    else
      redirect_to new_category_path
    end
  end

  def index
    @categories = Category.find_by_sql("SELECT DISTINCT categories.id, categories.name, categories.icon,
    categories.created_at, SUM(transactions.amount) AS amount, users.id as user_id FROM \"categories\"
    LEFT JOIN transactions ON transactions.category_id = categories.id
    LEFT JOIN users ON users.id = categories.user_id
    WHERE \"categories\".\"user_id\" = #{current_user.id} GROUP BY categories.id, categories.name, users.id")
  end

  def destroy
    if @category.destroy
      redirect_to categories_path, notice: 'Category has been deleted successfully'
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

  def find_category
    @category = Category.includes(:transactions).find(@category_id)
  end
end
