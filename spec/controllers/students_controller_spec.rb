require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  before do
    @user = FactoryGirl.create(:user)
  end

  describe '#index' do
    before do
      controller_sign_in_as(@user)
    end

    it "assigns all students to @students" do
      get :index
      expect(assigns(:students)).to eq(Student.all)
    end

    it "renders :index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "redirects when user is not logged in" do
      request.session[:user_id] = nil
      get :index
      expect(response).to redirect_to(:login)
    end
  end

  describe "#show" do
    before do
      controller_sign_in_as(@user)
      @student = FactoryGirl.create(:student)
    end

    it "assigns @student" do
      get :show, id: @student.id
      expect(assigns(:student)).to eq(@student)
    end

    it "renders :show template" do
      get :show, id: @student.id
      expect(response).to render_template(:show)
    end

    it "redirects when user is not logged in" do
      request.session[:user_id] = nil
      get :show, id: @student.id
      expect(response).to redirect_to(:login)
    end
  end

  describe "#new" do
    before do
      controller_sign_in_as(@user)
    end

    it "assigns a new student to @student" do
      get :new
      expect(assigns(:student)).to be_a_new(Student)
    end

    it "renders :new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "redirects when not signed in" do
      request.session[:user_id] = nil
      get :new
      expect(response).to redirect_to(:login)
    end
  end

  describe "#create" do
    before do
      controller_sign_in_as(@user)
    end

    describe "with valid input" do
      it "creates a new student" do
        expect {
          post :create, student: FactoryGirl.attributes_for(:student)
        }.to change(Student, :count).by(1)
      end

      it "redirects to root_path" do
        post :create, student: FactoryGirl.attributes_for(:student)
        expect(response).to redirect_to(root_path)
      end

      it "redirects to /login if not logged in" do
        request.session[:user_id] = nil
        post :create, student: FactoryGirl.attributes_for(:student)
        expect(response).to redirect_to(login_path)
      end
    end

    describe "with invalid input" do
      it "doesn't create a new student" do
        expect {
          post :create, student: FactoryGirl.attributes_for(:invalid_student)
        }.to_not change(Student, :count)
      end

      it "renders :new template" do
        post :create, student: FactoryGirl.attributes_for(:invalid_student)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "#edit" do
    before do
      controller_sign_in_as(FactoryGirl.create(:user))
      @student = FactoryGirl.create(:student)
    end

    it "assigns @student" do
      get :edit, id: @student.id
      expect(assigns(:student)).to eq(@student)
    end

    it "renders :edit template" do
      get :edit, id: @student.id
      expect(response).to render_template(:edit)
    end

    it "redirects to /login if not logged in" do
      request.session[:user_id] = nil
      get :edit, id: @student.id 
      expect(response).to redirect_to(login_path)
    end
  end

  describe "#update" do
    describe "with valid input" do
      it "updates the student's attributes"
      it "redirects to student's show page"
    end

    describe "with invalid input" do
      it "doesn't update the student's attributes"
      it "renders :edit template"
    end
  end

  describe "#destroy" do
    it "deletes the user"
  end

  # TODO describe "#find_student"
end
