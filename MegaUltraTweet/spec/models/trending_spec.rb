require 'rails_helper'
require 'spec_helper'

describe Trending do

  it "has a valid factory" do
    expect(FactoryGirl.create(:trending)).to be_valid
  end

  it "is invalid without a id" do
    expect(FactoryGirl.build(:trending, id: nil)).not_to be_valid
  end

  it "is invalid without a created_at" do
    expect(FactoryGirl.build(:trending, created_at: nil)).not_to be_valid
  end

  it "is invalid without a updated_at" do
    expect(FactoryGirl.build(:trending, updated_at: nil)).not_to be_valid
  end

  describe "#get_popular" do
    it "returns the popular hashtags"
  end

  describe "#get_unpopular" do
    it "returns the unpopular hashtags"
  end

  describe "#reset_hashtags" do
    it "resets the trending hashtags"
  end

  describe "#set_hashtags" do
    it "sets the trending hashtags to the given ones"
  end

  describe "#build_new" do
    #TODO write better description
    it "does something"
  end

end
