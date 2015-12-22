module BooksHelper
  def suggested_book_number
    unless Book.all.empty?
      Book.order(:number).last.number + 1
    else
      1
    end
  end
end
