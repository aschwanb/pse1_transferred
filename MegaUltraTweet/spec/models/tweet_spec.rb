require 'rails_helper'
require 'spec_helper'

describe Tweet do

  it "has a valid factory" do
    expect(FactoryGirl.create(:tweet)).to be_valid
  end

  it "is invalid without a id" do
    expect(FactoryGirl.build(:tweet, id: nil)).not_to be_valid
  end

  it "is invalid without a text" do
    expect(FactoryGirl.build(:tweet, text: nil)).not_to be_valid
  end

  it "is invalid without a retweets" do
    expect(FactoryGirl.build(:tweet, retweets: nil)).not_to be_valid
  end

  it "is invalid without a twitter_id" do
    expect(FactoryGirl.build(:tweet, twitter_id: nil)).not_to be_valid
  end

  it "is invalid without a author_id" do
    expect(FactoryGirl.build(:tweet, author_id: nil)).not_to be_valid
  end

  it "is invalid without a crated_at" do
    expect(FactoryGirl.build(:tweet, created_at: nil)).not_to be_valid
  end

  it "is invalid without a updated_at" do
    expect(FactoryGirl.build(:tweet, updated_at: nil)).not_to be_valid
  end

  describe "#by_hashtags" do
    #TODO write better description
    it "does something"
  end

  describe "#set_hashtags" do
    it "sets the hashtags of the tweet"
  end

  describe "#set_webpages" do
    it "sets the webpages of the tweet"
  end

  describe "#get_webpages" do
    it "returns the webpages of the tweet"
  end

  describe "#get_text" do
    it "returns the text of the tweet" do
      tweet = FactoryGirl.create(:tweet, text: "test")
      expect(tweet.get_text).to eq("test")
    end
  end

  describe "#get_hashtags" do
    it "returns the hashtags of the tweet"
  end

  describe "#get_retweets_count" do
    it "returns the retweets count of the tweet" do
      tweet = FactoryGirl.create(:tweet, retweets: 5)
      expect(tweet.get_retweets_count).to eq(5)
    end
  end

  describe "#get_author" do
    it "returns the author of the tweet"
  end

  describe "#get_rank" do
    it "returns the rank of the tweet"
  end

end