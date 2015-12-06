class BooksController < ApplicationController
  before_action :require_signin
  before_action :set_book

  def index
    @books = Book.all
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @book }
    end
  end

  def new
    @book = Book.new
    @books = Book.order(id: :desc)
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to new_book_path
    else
      @books = Book.order(id: :desc)
      render :new
    end
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

  def checkout
    if !params[:book_id].empty? && !params[:student_id].empty?
      book = Book.find(params[:book_id])
      book.check_out_book_to_student(params[:student_id])

      flash[:success] = "#{book.title} is due back on " +
                       "#{book.due.strftime('%A, %_m/%e/%Y')}"
      redirect_to root_path
    else
      flash[:error] = "Please select a book and student"
      redirect_to root_path
    end
  end

  def checkin
    @book = Book.find(params[:book_id])
    @book.check_in_book
    flash[:success] = "Thank you. #{@book.title} was successfully checked in."
    redirect_to checkin_path
  end

  def find_book
    if Book.exists?(params[:book])
      render json: Book.find(params[:book])
    # elsif Book.exists?(title: params[:book])
    #   render json: Book.find_by(title: params[:book])
    elsif Book.exists?(['title LIKE ?', "%#{params[:book]}%"])
      render json: Book.where("title LIKE ?", "%#{params[:book]}%")
    else
      render json: { message: "Couldn't find \"#{params[:book]}\"." }
    end
  end

  private
    def book_params
      params.require(:book).permit(:title)
    end

    def set_book
      @book = Book.find(params[:id]) if params[:id]
    end
end
