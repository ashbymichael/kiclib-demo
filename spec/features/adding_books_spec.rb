require 'rails_helper'

describe "Adding books" do
  before do
    @user = FactoryGirl.create(:user)
    @book = FactoryGirl.build(:book)
    
    sign_in_as(@user)
  end

  it "loads the new book path (when logged in)" do
    visit new_book_path
    expect(page).to have_content("New Book")
    expect(current_path).to eq('/books/new')
  end

  it "creates a new book with valid input" do
    visit new_book_path
    expect{
      fill_in('book[title]', with: Faker::Lorem.sentence)
      click_button('Submit')
    }.to change(Book, :count).by(1)
  end

  it "doesn't create a new book with invalid input" do
    visit new_book_path
    expect{
      fill_in('book[title]', with: nil)
      click_button('Submit')
    }.to_not change(Book, :count)
  end

  it "lists recently added books" do
    visit new_book_path
    fill_in('book[title]', with: @book.title)
    click_button('Submit')
    expect(page).to have_content(@book.title)
  end

  it "lists recently added books' IDs" do
    visit new_book_path
    fill_in('book[title]', with: @book.title)
    click_button('Submit')
    expect(page).to have_content(Book.last.id)
  end

  it "redirects if not logged in" do
    click_on('Sign out')
    visit new_book_path
    expect(page).to have_content('You need to sign in')
    expect(current_path).to eq('/login')
  end
end
