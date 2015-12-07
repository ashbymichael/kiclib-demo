require 'rails_helper'

feature "Checking out books" do
  describe "selecting book and student" do
    it "can search for a book by its title, or partial"
    it "is case insensitive when selecting a book"
    it "makes you select a book when searching by title"
    it "can search for a book by its id number"
    it "can search for a student by their name, or partial"
    it "can search for a student by their contact info, or partial"
    it "makes you select a student when searching by name or contact info"
    it "can select a student by their id number"
  end

  describe "with valid student and book" do
    it "checks out the book to the student"
    it "sets the due date to two weeks in the future"
  end

  describe "with invalid student or book" do
    it "redirects back to the checkout page"
    it "gives the user an error message"
  end
end
