require 'rails_helper'
require 'spec_helper'

describe Hashtag do

  it "has a valid factory" do
    expect(FactoryGirl.create(:hashtag)).to be_valid
  end

  it "is invalid without a id" do
    expect(FactoryGirl.build(:hashtag, id: nil)).not_to be_valid
  end

  it "is invalid without a text" do
    expect(FactoryGirl.build(:hashtag, text: nil)).not_to be_valid
  end

  it "is invalid without a created_at" do
    expect(FactoryGirl.build(:hashtag, created_at: nil)).not_to be_valid
  end

  it "is invalid without a updated_at" do
    expect(FactoryGirl.build(:hashtag, updated_at: nil)).not_to be_valid
  end

  describe "#get_text" do
    it "returns the text of the hashtag" do
      hashtag = FactoryGirl.create(:hashtag, text: "test")
      expect(hashtag.get_text).to eq("test")
    end
  end

  describe "#get_rank" do
    it "returns the rank of the hashtag"
  end

  describe "#set_rank" do
    it "set the rank of the hashtag"
  end

  describe "#get_rank" do
    it "returns the rank of the hashtag"
  end

  describe "#get_trend_short" do
    it "returns the trend_short of the hashtag"
  end

  describe "#get_trend_long" do
    it "returns the trend_long of the hashtag"
  end

  describe "#get_tweets" do
    it "returns the tweets of the hashtag"
  end

end
