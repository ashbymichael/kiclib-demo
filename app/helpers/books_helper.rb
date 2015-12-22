module BooksHelper
  def suggested_book_number
    if Book.last
      Book.last.number + 1
    else
      1
    end
  end
end
