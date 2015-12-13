module BooksHelper
  def suggested_book_number
    if Book.last
      Book.last.id + 1
    else
      1
    end
  end
end
