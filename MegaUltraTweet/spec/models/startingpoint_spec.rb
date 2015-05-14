require 'rails_helper'
require 'spec_helper'

describe Startingpoint do

  it "has a valid factory" do
    expect(FactoryGirl.create(:startingpoint)).to be_valid
  end

  describe "#get_start" do
    it "returns the start hashtags"
  end

  describe "#add_popular_hashtags" do
    it "adds the given number hashtags to the startingpoint hashtags"
  end

  describe "#remove_unpopular_hashtags" do
    it "removes the given number hashtags to the startingpoint hashtags"
  end

  describe "#repair_defaults" do
    #TODO find better description
    it "should do something"
  end

end
