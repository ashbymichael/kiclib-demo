class Transaction < ActiveRecord::Base
  belongs_to :student
  belongs_to :book
end
