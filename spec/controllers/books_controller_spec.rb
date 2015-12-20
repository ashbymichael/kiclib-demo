require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  before do
    @user = FactoryGirl.create(:user)
  end

  describe "#index" do
    before do
      controller_sign_in_as(@user)
    end

    it "assigns all books to @books" do
      get :index
      expect(assigns(:books)).to match_array(Book.all)
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "redirects if not logged in" do
      controller_sign_out
      get :index
      expect(response).to redirect_to(login_path)
    end
  end

  describe "#show" do
    before do
      controller_sign_in_as(@user)
      @book = FactoryGirl.create(:book)
    end

    it "assigns the book to @book" do
      get :show, id: @book
      expect(assigns(:book)).to eq(@book)
    end

    it "renders the :show template" do
      get :show, id: @book
      expect(response).to render_template(:show)
    end

    it "redirects if not logged in" do
      controller_sign_out
      get :show, id: @book
      expect(response).to redirect_to(login_path)
    end
  end

  describe "#new" do
    before do
      controller_sign_in_as(@user)
    end

    it "assigns a new book to @book" do
      get :new
      expect(assigns(:book)).to be_a_new(Book)
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "redirects if not logged in" do
      controller_sign_out
      get :new
      expect(response).to redirect_to(login_path)
    end
  end

  describe "#create" do
    before do
      controller_sign_in_as(@user)
    end

    describe "with valid input" do
      it "saves a new book with valid input" do
        expect {
          post :create, book: FactoryGirl.attributes_for(:book)
        }.to change(Book, :count).by(1)
      end

      it "redirects to new_book_path" do
        post :create, book: FactoryGirl.attributes_for(:book)
        expect(response).to redirect_to(new_book_path)
      end
    end

    describe "with invalid input" do
      it "doesn't save a new book with invalid input" do
        expect {
          post :create, book: FactoryGirl.attributes_for(:book, title: nil)
        }.to_not change(Book, :count)
      end

      it "renders :new template" do
        post :create, book: FactoryGirl.attributes_for(:book, title: nil)
        expect(response).to render_template(:new)
      end
    end

    it "redirects to /login if not logged in" do
      controller_sign_out
      post :create, book: FactoryGirl.attributes_for(:book)
      expect(response).to redirect_to(login_path)
    end
  end

  describe "#edit" do
    before do
      controller_sign_in_as(@user)
      @book = FactoryGirl.create(:book)
    end

    it "assigns the correct book to @book" do
      get :edit, id: @book
      expect(assigns(:book)).to eq(@book)
    end

    it "renders :edit template" do
      get :edit, id: @book
      expect(response).to render_template(:edit)
    end

    it "redirects to /login when not logged in" do
      controller_sign_out
      get :edit, id: @book
      expect(response).to redirect_to(login_path)
    end
  end

  describe "#update" do
    before do
      controller_sign_in_as(@user)
      @book = FactoryGirl.create(:book)
    end

    describe "with valid input" do
      it "saves changes to @book" do
        new_title = Faker::Lorem.sentence
        patch :update, id: @book, book: {title: new_title}
        expect(Book.find(@book.id).title).to eq(new_title)
      end

      it "redirects to #index" do
        patch :update, id: @book, book: {title: "laskdfaeiwofj"}
        expect(response).to redirect_to(books_path)
      end
    end

    describe "with invalid input" do
      it "doesn't save changes to @book" do
        patch :update, id: @book, book: {title: nil}
        expect(Book.find(@book.id).title).to eq(@book.title)
      end

      it "renders :edit template" do
        patch :update, id: @book, book: {title: nil}
        expect(response).to render_template(:edit)
      end
    end

    it "redirects to /login if not logged in" do
      controller_sign_out
      patch :update, id: @book, book: {title: "sdfergqgqr"}
      expect(response).to redirect_to(login_path)
    end
  end

  describe "#destroy" do
    before do
      controller_sign_in_as(@user)
      @book = FactoryGirl.create(:book)
    end

    it "deletes the book" do
      expect{
        delete :destroy, id: @book
      }.to change(Book, :count).by(-1)
    end

    it "redirects to /login if not logged in" do
      controller_sign_out
      delete :destroy, id: @book
      expect(response).to redirect_to(login_path)
    end
  end
end
