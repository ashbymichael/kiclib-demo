class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.datetime :due
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
