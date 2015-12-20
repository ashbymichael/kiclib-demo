class LibraryController < ApplicationController
  before_action :require_signin

  def index
  end

  def admin
  end

  def checkin
    @active_transactions = Transaction.where(status: 'out')
    @checked_out_books = Book.where("student_id IS NOT NULL")
  end

  def overdue
    @overdue_books = Book.where(["due < ?", DateTime.now])
  end
end
