require 'rails_helper'
require 'spec_helper'

describe Startingpoint do

  it "has a valid factory" do
    expect(FactoryGirl.create(:startingpoint)).to be_valid
  end

 end
