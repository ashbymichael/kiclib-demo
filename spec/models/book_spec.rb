require 'rails_helper'

RSpec.describe Book, type: :model do
  it "accepts valid inputs" do
    expect(FactoryGirl.build(:book)).to be_valid
  end

  it "is invalid without a title" do
    expect(FactoryGirl.build(:book, title: nil)).to_not be_valid
  end
end
