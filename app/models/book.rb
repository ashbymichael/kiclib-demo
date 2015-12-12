class Book < ActiveRecord::Base
  validates :title, presence: true
  validates :number, presence: true, uniqueness: true
  belongs_to :student

  LENGTH = 2.weeks

  def check_out_book_to_student(student_id)
    update_attributes(student_id: student_id, due: Time.now + LENGTH)
  end


  def check_in_book
    update_attributes(student_id: nil, due: nil)
  end

  def checked_out?
    return true if student_id
    false
  end
end
