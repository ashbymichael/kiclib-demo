class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.where(status: 'out')
  end

  def create
    if checkout_params_ok?
      check_out_book
    else
      flash[:error] = "Please select a book and student"
    end
    redirect_to root_url
  end

  def check_in
    @transaction = Transaction.find(params[:id])
    if @transaction.update_attributes(status: 'complete')
      flash[:success] = "Checked in. Thanks!"
    else
      flash[:error] = "Book not checked in.  Something went wrong."
    end
    redirect_to root_url
  end

  private
    def transaction_params
      params.require(:transaction).permit(:book_id, :student_id)
    end

    def checkout_params_ok?
      return true if params[:transaction][:book_id] &&
                     !params[:transaction][:book_id].empty? &&
                     params[:transaction][:student_id] &&
                     !params[:transaction][:student_id].empty?
    end

    def check_out_book
      @transaction = Transaction.new(transaction_params)
      @transaction.due = Time.now + 2.weeks
      if @transaction.save
        flash[:success] = "#{Book.find(params[:transaction][:book_id]).title}" +
                " is due back on #{@transaction.due.strftime('%A, %-m/%-d/%Y')}"
      else
        flash[:error] = "Book not checked out"
      end
    end
end
