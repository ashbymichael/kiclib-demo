module BooksHelper
  def suggested_book_number
    Book.last.id + 1 if Book.last 
  end
end
