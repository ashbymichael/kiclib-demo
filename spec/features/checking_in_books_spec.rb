require 'rails_helper'

feature "Checking in books:" do
  before do
    @user = FactoryGirl.create(:user)
    @student = FactoryGirl.create(:student)
    @book = FactoryGirl.create(:book)
    @book.check_out_book_to_student(@student.id)

    visit login_path
    fill_in('session[username]', with: @user.username)
    fill_in('session[password]', with: @user.password)
    click_button("Sign in")

    visit checkin_path
  end

  describe "Return Books Page" do
    it "finds books by id", js: true do
      fill_in("book", with: @book.id)
      click_button("ci_find_book_button")

      within("#ci_book_div") do
        expect(page).to have_content(@book.title)
      end
    end

    it "finds books by title", js: true do
      fill_in("book", with: @book.title)
      click_button("ci_find_book_button")

      within("#ci_book_div") do
        expect(page).to have_content(@book.title)
      end
    end

    it "tells user if book is not checked out with 1 result", js: true do
      @book.check_in_book
      expect(@book.checked_out?).to be(false)

      fill_in("book", with: @book.id)
      click_button("ci_find_book_button")

      within("#ci_book_div") do
        expect(page).to have_content("#{@book.title} is not checked out.")
      end
    end

    it "tells user book is not checked out with multiple results", js: true do
      @book.check_in_book
      expect(@book.checked_out?).to be(false)
      FactoryGirl.create(:book, title: @book.title)

      fill_in("book", with: @book.title)
      click_button("ci_find_book_button")

      within("#ci_book_div") do
        expect(page).to have_content("#{@book.title} is not checked out.")
      end
    end

    it "hides the check in button when no book selected", js: true do
      within("#ci_book_info_form_div") do
        expect(page).to_not have_content('Check in')
      end

      fill_in("book", with: @book.id)
      click_button("ci_find_book_button")

      within("#ci_book_info_form_div") do
        expect(page).to have_content('Check in')
      end
    end
  end

  describe "Clicking 'Check in' button" do
    it "checks a book in", js: true do
      fill_in("book", with: @book.id)
      click_button("ci_find_book_button")

      within("#ci_book_info_form_div") do
        click_button("Check in")
      end

      @book.reload
      expect(@book.checked_out?).to be(false)
    end
  end

  describe "Clicking 'Check in' in the books list" do
    it "checks the book in", js: true do
      fill_in("book", with: @book.id)
      click_button("ci_find_book_button")

      within("#checked_out_books_div") do
        click_button("Check in")
      end

      @book.reload
      expect(@book.checked_out?).to be(false)
    end
  end
end
