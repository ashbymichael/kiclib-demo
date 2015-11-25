class BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def create
    @book = Book.create(book_params)
    redirect_to new_book_path
  end

  private
    def book_params
      params.require(:book).permit(:title)
    end
end
