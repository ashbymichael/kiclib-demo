class Student < ActiveRecord::Base
  validates :name, presence: true
  validates :contact, presence: true, uniqueness: true
end
