class RemoveUserFromBook < ActiveRecord::Migration
  def change
    remove_reference :books, :user, index: true, foreign_key: true
  end
end
