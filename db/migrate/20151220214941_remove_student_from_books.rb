class RemoveStudentFromBooks < ActiveRecord::Migration
  def change
    remove_reference :books, :student, index: true, foreign_key: true
  end
end
