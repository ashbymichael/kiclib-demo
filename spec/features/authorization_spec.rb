require 'rails_helper'

feature "Authorization" do

  describe "when signed in" do
    before do
      @user = FactoryGirl.create(:user)
      visit login_path
      fill_in('session[username]', with: @user.username)
      fill_in('session[password]', with: @user.password)
      within('main') do
        click_button('Sign in')
      end
    end

    it "has no 'sign in' link" do
      visit '/'
      expect(page).to_not have_link('Sign in')
    end

    it "has a 'sign out' link" do
      visit admin_path
      expect(page).to have_link('Sign out')
    end

    it "can't access login_path" do
      visit login_path
      expect(page).to have_content('already signed in.')
      expect(current_path).to eq('/')
    end

    it "can access checkout_path" do
      visit checkout_path
      expect(page).to have_content('Check out books')
    end

    it "can access checkin_path" do
      visit checkin_path
      expect(current_path).to eq('/checkin')
      expect(page).to have_content('Return book')
    end

    it "can access admin_path" do
      visit admin_path
      expect(page).to have_content('Admin')
    end
  end

  describe "when not signed in" do
    it "has a 'sign in' link" do
      visit root_path
      expect(page).to have_button('Sign in')
    end

    it "has no 'sign out' link" do
      visit root_path
      expect(page).to_not have_link('Sign out')
    end

    it "can access login_path" do
      visit login_path
      # expect(page).to have_content('Sign in')
      expect(current_path).to eq('/login')
    end

    it "can't access checkout_path" do
      visit checkout_path
      expect(current_path).to eq('/login')
      expect(page).to have_content('You need to sign in')
    end

    it "can't access checkin_path" do
      visit checkin_path
      expect(current_path).to eq('/login')
      expect(page).to have_content('You need to sign in')
    end

    it "can't access admin_path" do
      visit admin_path
      expect(current_path).to eq('/login')
      expect(page).to have_content('You need to sign in')
    end
  end
end
