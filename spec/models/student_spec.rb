require 'rails_helper'

RSpec.describe Student, type: :model do
  it "accepts valid inputs" do
    expect(FactoryGirl.build(:student)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:student, name: nil)).to_not be_valid
  end

  it "is invalid without contact info" do
    expect(FactoryGirl.build(:student, contact: nil)).to_not be_valid
  end

  it "is invalid with duplicate contact info" do
    FactoryGirl.create(:student, contact: 'duplicate')
    expect(FactoryGirl.build(:student, contact: 'duplicate')).to_not be_valid
  end
end
