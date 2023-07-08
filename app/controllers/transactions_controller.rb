class TransactionsController < ApplicationController
  # This is same as laad_and_authorize_resource but lighter
  check_authorization
  skip_authorization_check

  before_action :find_transaction, only: %i[edit delete]

  def new
    @transaction = Transaction.new
  end

  def index
    @transactions = Transaction.where(category_id: @category_id).order(created_at: 'DESC')
    @category = find_category
  end

  def create
    @transaction = Transaction.new(post_params)
    @transaction.category_id = @category_id

    if @transaction.save
      return redirect_to category_transactions_path(@category_id), notice: 'Transaction added successfully'
    end

    redirect_to new_category_transaction_path
  end

  def edit; end

  def destroy
    if @category.destroy
      redirect_to categories_path, notice: 'Transaction deleted successfully'
    else
      redirect_to categories_path
    end
  end

  def post_params
    params.require(:transaction).permit(:amount, :name)
  end

  def find_category
    @category = Category.find_by_sql("SELECT DISTINCT categories.id, users.id as user_id, categories.name
        , categories.icon, categories.created_at, SUM(transactions.amount) AS amount FROM \"categories\"
        LEFT JOIN transactions ON transactions.category_id = categories.id
        LEFT JOIN users ON users.id = categories.user_id
        WHERE \"categories\".\"id\" = #{@category_id} GROUP BY categories.id, categories.name, users.id").first
  end

  def find_transaction
    @transaction = Transaction.includes(:category).find(@transaction_id)
  end
end
