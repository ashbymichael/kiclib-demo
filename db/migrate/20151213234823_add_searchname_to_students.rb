class AddSearchnameToStudents < ActiveRecord::Migration
  def change
    add_column :students, :search_name, :string
  end
end
