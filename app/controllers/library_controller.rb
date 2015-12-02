class LibraryController < ApplicationController
  before_action :require_signin!

  def index
  end

  def admin
  end

  def checkin
    @checked_out_books = Book.where("student_id IS NOT NULL")
  end
end
