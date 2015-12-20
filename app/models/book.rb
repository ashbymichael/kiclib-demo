class Book < ActiveRecord::Base
  validates :title, presence: true
  validates :number, presence: true, uniqueness: true
  # belongs_to :student
  has_many :transactions
  before_save :make_searchable_title

  LENGTH = 2.weeks

  def check_out_book_to_student(student_id)
    update_attributes(student_id: student_id, due: Time.now + LENGTH)
  end


  def check_in_book
    update_attributes(student_id: nil, due: nil)
  end

  def checked_out?
    return true unless Transaction.where(book_id: id, status: 'out').empty?
  end

  def student
    transaction = Transaction.where(book_id: id, status: 'out').first
    transaction.student
  end

  def active_transaction
    Transaction.where(book_id: id, status: 'out').first
  end

  private
    def make_searchable_title
      self.search_title = title.gsub(/\s+/, '').downcase
    end

end
