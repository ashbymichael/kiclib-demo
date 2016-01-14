class Book < ActiveRecord::Base
  validates :title, presence: true
  validates :number, presence: true, uniqueness: true
  # belongs_to :student
  has_many :transactions
  before_save :make_searchable_title

  LENGTH = 2.weeks

  def checked_out?
    return true unless Transaction.where(book_id: id, status: 'out').empty?
  end

  def student
    transaction = Transaction.where(book_id: id, status: 'out').first
    transaction.student if transaction
  end

  def active_transaction
    Transaction.where(book_id: id, status: 'out').first
  end

  def status
    return 'out' if checked_out?
    'in'
  end

  private
    def make_searchable_title
      self.search_title = title.gsub(/\s+/, '').downcase
    end

end
