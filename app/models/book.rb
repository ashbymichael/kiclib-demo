class Book < ActiveRecord::Base
  belongs_to :student

  LENGTH = 2.weeks

  def check_out_book_to_student(student)
    self.update_attributes(student_id: student, due: Time.now + LENGTH)
  end
end
