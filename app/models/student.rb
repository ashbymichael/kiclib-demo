class Student < ActiveRecord::Base
  validates :name, presence: true
  validates :contact, uniqueness: true
  validates :sid, presence: true, uniqueness: true
  # has_many :books, dependent: :nullify
  has_many :transactions
  before_save :make_searchable_name, :downcase_contact

  def self.import(file)
    CSV.foreach(file.tempfile, headers: false) do |row|
      Student.create(sid: row[0], name: row[1])
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
