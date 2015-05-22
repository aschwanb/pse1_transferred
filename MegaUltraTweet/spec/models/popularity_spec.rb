require 'rails_helper'
require 'spec_helper'

describe Popularity do
  it "has a valid factory" do
    expect(FactoryGirl.create(:popularity)).to be_valid
  end

  it "is invalid without a popular_id" do
    expect(FactoryGirl.build(:popularity, popular_id: nil)).not_to be_valid
  end

  it "is invalid without a popular_type" do
    expect(FactoryGirl.build(:popularity, popular_type: nil)).not_to be_valid
  end

  it "is invalid without a times_used" do
    expect(FactoryGirl.build(:popularity, times_used: nil)).not_to be_valid
  end

end