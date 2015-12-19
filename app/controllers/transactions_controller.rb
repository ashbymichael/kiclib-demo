class TransactionsController < ApplicationController
  def create
    p params
    if checkout_params_ok?
      @transaction = Transaction.new(transaction_params)
      @transaction.due = Time.now + 2.weeks 
      if @transaction.save
        flash[:success] = "Due on #{@transaction.due}"
        redirect_to root_url
      else
        flash[:error] = "Book not checked out"
        redirect_to root_url
      end
    else
      flash[:error] = "Please select a book and student"
      redirect_to root_url
    end
  end

  private
  def transaction_params
    params.require(:transaction).permit(:book_id, :stuent_id)
  end

  def checkout_params_ok?
    return true if params[:transaction][:book_id] && !params[:transaction][:book_id].empty? &&
                   params[:transaction][:student_id] && !params[:transaction][:student_id].empty?
  end
end
