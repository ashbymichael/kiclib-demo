class Student < ActiveRecord::Base
  validates :name, presence: true
  validates :sid, presence: true, uniqueness: true
  has_many :books, dependent: :nullify
  before_save { self.search_name = name.gsub(/\s+/, "").downcase! }
end
