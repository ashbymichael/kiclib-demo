class AddStudentToBooks < ActiveRecord::Migration
  def change
    add_reference :books, :student, index: true, foreign_key: true
  end
end
