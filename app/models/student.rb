class Student < ActiveRecord::Base
  validates :name, presence: true
  validates :sid, presence: true, uniqueness: true
  has_many :books, dependent: :nullify
  before_save :make_searchable_name

  private
    def make_searchable_name
      self.search_name = name.gsub(/\s+/, "").downcase!
    end
end
