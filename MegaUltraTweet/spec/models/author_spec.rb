require 'rails_helper'
require 'spec_helper'

describe Author do

  it "has a valid factory" do
    expect(FactoryGirl.create(:author)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:author, name: nil)).not_to be_valid
  end

  it "is invalid without a twitter_id" do
    expect(FactoryGirl.build(:author, twitter_id: nil)).not_to be_valid
  end

  it "is invalid without a friends_count" do
    expect(FactoryGirl.build(:author, friends_count: nil)).not_to be_valid
  end


  it "is invalid without a followers_count" do
    expect(FactoryGirl.build(:author, followers_count: nil)).not_to be_valid
  end


  it "is invalid without a screen_name" do
    expect(FactoryGirl.build(:author, screen_name: nil)).not_to be_valid
  end

  describe "#get_name" do
    it "returns the name of the author" do
      author = FactoryGirl.create(:author, name: "John")
      expect(author.get_name).to eq("John")
    end
  end

  describe "#get_firends_count" do
    it "returns the friends_count of the author" do
      author = FactoryGirl.create(:author, friends_count: 10)
      expect(author.get_friends_count).to eq(10)
    end
  end

  describe "#get_followers_count" do
    it "returns the followers_count of the author" do
      author = FactoryGirl.create(:author, followers_count: 10)
      expect(author.get_followers_count).to eq(10)
    end
  end

  describe "#get_rank" do
    it "returns the rank of the author" do
      author = FactoryGirl.create(:author, followers_count: 10)
      expect(author.get_rank).to eq(10)
    end
  end

end


