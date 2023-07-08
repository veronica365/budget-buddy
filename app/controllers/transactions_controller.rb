class TransactionsController < ApplicationController
    before_action :find_transaction, only: [:edit, :delete]

    def new
        @transaction = Transaction.new
    end

    def index
        @transactions = Transaction.where(category_id: params[:category_id]).order(created_at: 'DESC')
        @category = find_category
    end
    
    def create
        @transaction = Transaction.new(post_params)
        @transaction.category_id = params[:category_id]

        return redirect_to category_transactions_path(params[:category_id]) if @transaction.save
        
        redirect_to new_category_transaction_path
    end

    def edit; end
    
    def destroy
        if @category.destroy
        redirect_to  categories_path, notice: "Category has been deleted successfully"
        else
        redirect_to categories_path
        end
    end

    def post_params
        params.require(:transaction).permit(:amount, :name)
    end
    
    def find_category
        @category = Category.find_by_sql("SELECT DISTINCT categories.id, categories.name, categories.icon, categories.created_at, SUM(transactions.amount) AS amount
        FROM \"categories\"
        LEFT JOIN transactions ON transactions.category_id = categories.id
        WHERE \"categories\".\"id\" = #{params[:category_id]}
        GROUP BY categories.id, categories.name").first
    end

    def find_transaction
        @transaction = Transaction.includes(:category).find(params[:id])
    end
end

