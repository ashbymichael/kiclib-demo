require 'rails_helper'

feature "Logging in" do
  before do
    @user = FactoryGirl.create(:user)
  end

  it "works with a valid username/password" do
    visit '/login'
    fill_in "Username", with: @user.username
    fill_in "Password", with: @user.password
    click_on "Sign in"
    expect(page).to have_content("Hello, #{@user.username}")
  end

  it "doesn't work with an invalid username" do
    visit '/login'
    fill_in "Username", with: Faker::Name.first_name
    fill_in "Password", with: @user.password
    click_on "Sign in"
    expect(page).to have_content("Sorry,")
  end

  it "doesn't work with an invalid password" do
    visit '/login'
    fill_in "Username", with: @user.username
    fill_in "Password", with: Faker::Lorem.word
    click_on "Sign in"
    expect(page).to have_content("Sorry,")
  end

end
