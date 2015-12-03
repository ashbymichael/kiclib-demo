require 'rails_helper'

feature "Authorization" do
  describe "signed in" do
    it "has no 'sign in' link"
    it "can't access login_path"
    it "can access checkout_path"
  end

  describe "not signed in" do

  end
end
