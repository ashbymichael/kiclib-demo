require 'rails_helper'

RSpec.describe User, type: :model do

  it "is valid with a username and password" do
    expect(FactoryGirl.build(:user)).to be_valid
  end

  it "is invalid without a username" do
    expect(FactoryGirl.build(:user, username: nil)).to_not be_valid
  end

  it "is invalid with a duplicate username" do
    FactoryGirl.create(:user, username: 'testuser')
    expect(FactoryGirl.build(:user, username: 'testuser')).to_not be_valid
  end

  it "is invalid with a username shorter than 3 characters" do
    expect(FactoryGirl.build(:user, username: 'tt')).to_not be_valid
  end

  it "is invalid without a password" do
    expect(FactoryGirl.build(:user, password: nil)).to_not be_valid
  end

  it "is invalid with a password shorter than 6 characters" do
    expect(FactoryGirl.build(:user, password: 'pass')).to_not be_valid
  end

  it "is invalid when password and password_confirmation are different" do
    expect(FactoryGirl.build(:user, password: 'password',
                             password_confirmation: 'a;sldkfj')).to_not be_valid
  end
end
