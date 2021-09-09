class TransactionsController < ApplicationController
    def index
        @transactions = Transaction.paginate(page: params[:page])
        ensure_admin!
    end
    
    def ensure_admin!
        unless current_user and current_user.admin?
            redirect_to root_url
            flash[:danger] = "You do not have proper authorization"
        end
    end
    
    def create
        @transaction = Transaction.new(units_params)
        if @transaction.save
            flash[:success] = "Unit created!"
            redirect_to "/transactions"
        else
            flash[:danger] = "Error: Unit was not created"
            redirect_to "/transaction"
        end

    end
    
    def destroy
        Transaction.find(params[:id]).destroy
        flash[:success] = "Transaction deleted"
        redirect_to '/transactions'
    end
    private
        def units_params
            params.require(:transaction).permit(:category,:unit,:user)
        end
end
