class BooksController < ApplicationController
  before_action :set_book

  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.create(book_params)
    redirect_to new_book_path
  end

  def edit
  end

  def update
    if @book.update_attributes(book_params)
      redirect_to books_path
    else
      render 'edit'
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  private
    def book_params
      params.require(:book).permit(:title)
    end

    def set_book
      @book = Book.find(params[:id]) if params[:id]
    end
end
