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

  describe "#get_times_used" do
    it "returns times_used of the popularity"
  end

  describe "#set_times_used" do
    it "changes times_used of the popularity"
  end

  describe "#get_times_used" do
    it "returns times_used of the popularity"
  end


  describe "#get_trend_short" do
    it "returns the trend_short of the popularity"
  end

  describe "#get_trend_long" do
    it "returns the trend_long of the popularity"
  end

  describe "#add_new" do
    it "adds a new times_used"
  end

  describe "#delete_oldest" do
    it "deletes the oldest times_used"
  end


end