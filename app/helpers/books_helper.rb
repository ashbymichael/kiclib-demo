module BooksHelper
  def suggested_book_number
    Book.last.id + 1
  end
end
