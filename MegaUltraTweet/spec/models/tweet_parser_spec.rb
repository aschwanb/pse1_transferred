require 'rails_helper'
require 'spec_helper'

describe TweetParser do
  describe "#parse_webpages" do
    it "accepts a valid url" do
      tweet = FactoryGirl.create(:tweet, text: Faker::Internet.url)
      tweetparser = TweetParser.new
      webpages = tweetparser.parse_webpages(tweet)
      expect(webpages.empty?).to eq(false)
    end

    it "does not accept the ...error" do
      tweet = FactoryGirl.create(:tweet, text: "http://t.c...")
      tweetparser = TweetParser.new
      webpages = tweetparser.parse_webpages(tweet)
      expect(webpages.empty?).to eq(true)
    end

    it "accepts only the valid urls" do
      tweet = FactoryGirl.create(:tweet, text: "http://t.a...  https://www.google.ch  http://t.c...")
      tweetparser = TweetParser.new
      webpages = tweetparser.parse_webpages(tweet)
      webpages.each do |url|
        expect(url).to eq("https://www.google.ch")
      end
    end
  end
end