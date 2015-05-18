require 'rails_helper'
require 'spec_helper'

describe Hashtag do

  it "has a valid factory" do
    expect(FactoryGirl.create(:hashtag)).to be_valid
  end

  it "is invalid without a text" do
    expect(FactoryGirl.build(:hashtag, text: nil)).not_to be_valid
  end

  describe "#get_text" do
    it "returns the text of the hashtag" do
      hashtag = FactoryGirl.create(:hashtag, text: "test")
      expect(hashtag.get_text).to eq("test")
    end
  end


end
