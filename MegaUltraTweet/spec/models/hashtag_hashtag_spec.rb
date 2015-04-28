require 'rails_helper'
require 'spec_helper'

describe HashtagHashtag do

  it "has a valid factory" do
    expect(FactoryGirl.create(:hashtag_hashtag)).to be_valid
  end

  it "is invalid without a id" do
    expect(FactoryGirl.build(:hashtag_hashtag, id: nil)).not_to be_valid
  end

  it "is invalid without a hashtag_first_id" do
    expect(FactoryGirl.build(:hashtag_hashtag, hashtag_first_id: nil)).not_to be_valid
  end

  it "is invalid without a hashtag_second_id" do
    expect(FactoryGirl.build(:hashtag_hashtag, hashtag_second_id: nil)).not_to be_valid
  end

  it "is invalid without a created_at" do
    expect(FactoryGirl.build(:hashtag_hashtag, created_at: nil)).not_to be_valid
  end

  it "is invalid without a updated_at" do
    expect(FactoryGirl.build(:hashtag_hashtag, updated_at: nil)).not_to be_valid
  end

  describe "#get_rank" do
    it "returns the rank of the hashtag"
  end

  describe "#set_rank" do
    it "set the rank of the hashtag"
  end

  describe "#get_trend_short" do
    it "returns the trend_short of the hashtag"
  end

  describe "#get_trend_long" do
    it "returns the trend_long of the hashtag"
  end

end