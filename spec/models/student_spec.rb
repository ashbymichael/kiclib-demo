require 'rails_helper'

RSpec.describe Student, type: :model do
  it "accepts valid inputs" do
    expect(FactoryGirl.build(:student)).to be_valid
  end
end
