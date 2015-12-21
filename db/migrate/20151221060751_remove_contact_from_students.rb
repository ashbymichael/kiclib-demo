class RemoveContactFromStudents < ActiveRecord::Migration
  def change
    remove_column :students, :contact, :string
  end
end
