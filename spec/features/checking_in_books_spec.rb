require 'rails_helper'

feature "Checking in books:" do
  before do
    @user = FactoryGirl.create(:user)
    @student = FactoryGirl.create(:student)
    @book = FactoryGirl.create(:book)
    @transaction = FactoryGirl.create(:transaction, student: @student, book: @book)

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
      @transaction.update_attributes(status: 'complete')
      expect(@book.checked_out?).to_not be(true)

      fill_in("book", with: @book.id)
      click_button("ci_find_book_button")

      within("#ci_book_div") do
        expect(page).to have_content("#{@book.title} is not checked out.")
      end
    end

    it "tells user book is not checked out with multiple results", js: true do
      @transaction.check_in
      expect(@book.checked_out?).to_not be(true)
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
      expect(@book.checked_out?).to_not be(true)
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
      expect(@book.checked_out?).to_not be(true)
    end
  end
end
