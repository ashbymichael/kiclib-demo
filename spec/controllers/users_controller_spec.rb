require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#new" do
    it "assigns a new User to @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it "renders :new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    context "with valid attributes" do
      it "saves the new user to the database" do
        expect {
          post :create, user: FactoryGirl.attributes_for(:user)
        }.to change(User, :count).by(1)

      end

      it "redirects to root" do
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(response).to redirect_to root_path
      end
    end

    context "with invalid attributes" do
      it "does not save the new user" do
        expect{
          post :create, user: FactoryGirl.attributes_for(:invalid_user)
        }.to_not change(User, :count)
      end

      it "redirects to #new" do
        post :create, user: FactoryGirl.attributes_for(:invalid_user)
        expect(response).to redirect_to new_user_path
      end
    end
  end
end
