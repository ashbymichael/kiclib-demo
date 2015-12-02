class Student < ActiveRecord::Base
  validates :name, presence: true
  validates :contact, presence: true, uniqueness: true
  has_many :books, dependent: :nullify
end
