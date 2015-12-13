class Student < ActiveRecord::Base
  validates :name, presence: true
  validates :sid, presence: true, uniqueness: true
  has_many :books, dependent: :nullify
  before_save { contact.downcase! }
end
