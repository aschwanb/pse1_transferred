require 'rails_helper'
require 'spec_helper'

describe AuthorHashtag do
  it "has a valid factory" do
    expect(FactoryGirl.create(:author_hashtag)).to be_valid
  end

  it "is invalid without a id" do
    expect(FactoryGirl.build(:author_hashtag, id: nil)).not_to be_valid
  end

  it "is invalid without a author_id" do
    expect(FactoryGirl.build(:author_hashtag, author_id: nil)).not_to be_valid
  end

  it "is invalid without a hashtag_id" do
    expect(FactoryGirl.build(:author_hashtag, hashtag_id: nil)).not_to be_valid
  end

  describe "#get_rank" do
    it "returns the rank of the author_hashtag"
  end

  describe "#set_rank" do
    it "set the rank of the author_hashtag"
  end

  describe "#get_trend_short" do
    it "returns the trend_short of the author_hashtag"
  end

  describe "#get_trend_long" do
    it "returns the trend_long of the author_hashtag"
  end

end