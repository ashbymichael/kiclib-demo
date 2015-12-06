require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "#new" do
    describe "(when not logged in)" do
      before do
        controller_sign_out
      end

      it "renders :new template" do
        get :new
        expect(response).to render_template(:new)
      end
    end

    describe "(when logged in)" do
      before do
        controller_sign_in_as(FactoryGirl.create(:user))
      end

      it "redirects to root path" do
        get :new
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "#create" do
    before do
      @user = FactoryGirl.create(:user)
    end

    it "assigns user variable" do
      post :create, session: {username: @user.username,
                              password: @user.password}
      expect(assigns(:user)).to eq(@user)
    end

    describe "(with valid input)" do
      before :each do
        controller_sign_out
      end

      it "logs user in" do
        post :create, session: {username: @user.username,
                                password: @user.password}
        expect(controller.session[:user_id]).to eq(@user.id)
      end

      it "redirects to root_path" do
        post :create, session: {username: @user.username,
                                password: @user.password}
        expect(response).to redirect_to(root_path)
      end
    end

    describe"(with invalid input)" do
      before :each do
        controller_sign_out
      end

      it "doesn't log the user in" do
        post :create, session: {username: @user.username + "wrong",
                                password: @user.password + "sadfa"}
        expect(controller.session[:user_id]).to be_nil
      end
      it "renders :new template" do
        post :create, session: {username: @user.username + "wrong",
                                password: @user.password + "sadfa"}
        expect(response).to render_template(:new)
      end
    end
  end

  describe "#destroy" do
    before do
      controller_sign_in_as(FactoryGirl.create(:user))
    end

    it "logs the user out" do
      delete :destroy
      expect(controller.session[:user_id]).to be_nil
    end
  end
end
