require 'rails_helper'
require 'spec_helper'

describe Trending do

  it "has a valid factory" do
    expect(FactoryGirl.create(:trending)).to be_valid
  end

end
