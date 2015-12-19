class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :student, index: true, foreign_key: true
      t.references :book, index: true, foreign_key: true
      t.datetime :due
      t.string :status, default: "out"

      t.timestamps null: false
    end
  end
end
