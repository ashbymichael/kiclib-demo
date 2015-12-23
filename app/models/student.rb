class Student < ActiveRecord::Base
  validates :name, presence: true
  # validates :contact, uniqueness: true
  validates :sid, presence: true, uniqueness: true
  # has_many :books, dependent: :nullify
  has_many :transactions, dependent: :destroy

  before_save :make_searchable_name

  def self.import(file)
    CSV.foreach(file.tempfile, headers: false) do |row|
      student = Student.new(sid: row[0], name: row[1] + ' ' + row[2])
      student.save if student.valid?
    end
  end

  private
    def make_searchable_name
      self.search_name = name.gsub(/\s+/, "").downcase!
    end

    def downcase_contact
      contact.downcase!
    end
end
