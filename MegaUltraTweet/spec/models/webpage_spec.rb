require 'rails_helper'
require 'spec_helper'

describe Webpage do

  it "has a valid factory" do
    expect(FactoryGirl.create(:webpage)).to be_valid
  end

  it "is invalid without a url" do
    expect(FactoryGirl.build(:webpage, url: nil)).not_to be_valid
  end

  it "is invalid without a title" do
    expect(FactoryGirl.build(:webpage, title: nil)).not_to be_valid
  end

  it "is invalid without a description" do
    expect(FactoryGirl.build(:webpage, description: nil)).not_to be_valid
  end

  describe "#get_url" do
    it "returns the url of the webpage" do
      webpage = FactoryGirl.create(:webpage, url: "www.test.ch")
      expect(webpage.get_url).to eq("www.test.ch")
    end
  end

  describe "#get_tweets" do
    it "returns the tweets of the webpage"
  end

  describe "#get_title" do
    it "returns the title of the webpage" do
      webpage = FactoryGirl.create(:webpage, title: "test")
      expect(webpage.get_title).to eq("test")
    end
  end

  describe "#get_description" do
    it "returns the description of the webpage" do
      webpage = FactoryGirl.create(:webpage, description: "Test test test")
      expect(webpage.get_description).to eq("Test test test")
    end
  end

end
