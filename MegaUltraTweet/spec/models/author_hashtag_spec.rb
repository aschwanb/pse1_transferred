require 'rails_helper'
require 'spec_helper'

describe AuthorHashtag do

  it "has a valid factory" do
    expect(FactoryGirl.create(:author_hashtag)).to be_valid
  end

  it "is invalid without a author_id" do
    expect(FactoryGirl.build(:author_hashtag, author_id: nil)).not_to be_valid
  end

  it "is invalid without a hashtag_id" do
    expect(FactoryGirl.build(:author_hashtag, hashtag_id: nil)).not_to be_valid
  end



end