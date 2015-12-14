class AddSearchTitleToBooks < ActiveRecord::Migration
  def change
    add_column :books, :search_title, :string
  end
end
