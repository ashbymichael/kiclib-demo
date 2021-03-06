require 'rails_helper'

feature "Checking out books" do
  before do
    @book = FactoryGirl.create(:book)
    @student = FactoryGirl.create(:student)
    @user = FactoryGirl.create(:user)

    visit login_path
    fill_in("session[username]", with: @user.username)
    fill_in("session[password]", with: 'password')
    click_on("Sign in")

    visit checkout_path
  end

  describe "selecting book and student" do
    it "can search for a book by its title", js: true do
      fill_in("book", with: @book.title)
      click_on("co_find_book_button")

      within("#co_console") do
        expect(page).to have_content(@book.title)
      end
    end

    # TODO it "is case insensitive for book titles"

    it "makes you select a book when searching by title", js: true do
      fill_in("book", with: @book.title)
      click_on("co_find_book_button")

      within("#co_console") do
        expect(page).to have_content("Please select a book:")
      end
    end

    it "can search for a book by its number", js: true do
      fill_in("book", with: @book.number)
      click_on("co_find_book_button")

      within("#co_console") do
        expect(page).to have_content(@book.title)
      end
    end

    it "can search for a student by their name, or partial", js: true do
      fill_in("student", with: @student.name)
      click_on("co_find_student_button")

      within("#co_console") do
        expect(page).to have_content(@student.name[0..3])
      end
    end

    it "can search for a student by their SID", js: true do
      fill_in("student", with: @student.sid)
      click_on("co_find_student_button")

      within("#co_console") do
        expect(page).to have_content(@student.name)
      end
    end

    it "makes you select a student when searching by name/contact", js: true do
      fill_in("student", with: @student.name[0..2])
      click_on("co_find_student_button")

      within("#co_console") do
        expect(page).to have_content("Please select a student:")
      end
    end

    # it "is case insensitive for student contacts", js: true do
    #   new_student = FactoryGirl.create(:student, contact: 'AAa')
    #   fill_in("student", with: 'aaa')
    #   click_on("co_find_student_button")
    #
    #   within("#co_console") do
    #     expect(page).to have_content(new_student.name)
    #   end
    # end

    it "can select a student by their SID number", js: true do
      fill_in("student", with: @student.sid)
      click_on("co_find_student_button")

      within("#co_console") do
        expect(page).to have_content(@student.name)
      end
    end
  end

  describe "with valid student and book" do
    it "checks out the book to the student", js: true do
      fill_in("book", with: @book.number)
      click_on("co_find_book_button")
      fill_in("student", with: @student.sid)
      click_on("co_find_student_button")
      click_on("checkout_button")

      expect(Transaction.last.student).to eq(@student)
    end

    it "sets the due date to two weeks in the future", js: true do
      fill_in("book", with: @book.number)
      click_on("co_find_book_button")
      fill_in("student", with: @student.sid)
      click_on("co_find_student_button")
      click_on("checkout_button")

      expect(Transaction.last.due).to be_within(1.day).of(Time.now + 2.weeks)
    end
  end

  describe "with invalid student or book" do
    it "doesn't check out the book", js: true do
      expect {
        fill_in("book", with: @book.id)
        click_on("co_find_book_button")
        click_on("checkout_button")
      }.to_not change(Transaction, :count)
    end

    it "gives the user an error message", js: true do
      fill_in("book", with: @book.id)
      click_on("co_find_book_button")
      click_on("checkout_button")

      expect(page).to have_content("Please select a book and student")
    end
  end
end
