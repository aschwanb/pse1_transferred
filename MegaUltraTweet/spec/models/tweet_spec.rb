require 'rails_helper'
require 'spec_helper'

describe Tweet do

  it "has a valid factory" do
    expect(FactoryGirl.create(:tweet)).to be_valid
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

  describe "#get_text" do
    it "returns the text of the tweet" do
      tweet = FactoryGirl.create(:tweet, text: "test")
      expect(tweet.get_text).to eq("test")
    end
  end


  describe "#get_retweets_count" do
    it "returns the retweets count of the tweet" do
      tweet = FactoryGirl.create(:tweet, retweets: 5)
      expect(tweet.get_retweets_count).to eq(5)
    end
  end


end