require 'rubygems'
require 'twitter'
require 'uri'

class IndexController < ApplicationController

  def start
  end

  def search
    @topics = %w[
        #Technology
        #Technologie
        @technikneuheit
        @Technik_Tweets
        @ids_technik
        @BBCTech
        @techreview
    ]
  end

  def hashtag
    @query = params[:query]
    # Extract information from tweets
    # Client needs to be authenticated in order to access twitter api
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "tTrNPGMT8S1d3qK3LMlnZV1XP"
      config.consumer_secret     = "olUHmGtYlh6dx3ztWqa6ExLLek7Vb76vGEi5p5BMd2LiFWWHPD"
      config.access_token        = "3062227378-HaWeilWyykpsDQvwZmaGUUSHDmlOFlHxpHpC9RY"
      config.access_token_secret = "etP0a6eCI0q1FwfMJYUO0VsTWyrhbYKRvuvUS8YKH2kC3"
    end
    # Create empty arrays
    @hashtags = []
    @twitterHandles = []
    @webpages = []
    @twitterUser = []
    # Ask twitter
    @tweets = client.search(@query, :result_type => "recent").take(3).collect
    @tweets.each do |tweet|
      # Extract hashtag from tweet
      @hashtags = @hashtags + tweet.text.scan(/#\w+/).flatten
      @twitterHandles = @twitterHandles + tweet.text.scan(/@\w+/).flatten
      @webpages = @webpages + URI.extract("#{tweet.text}", /http|https/)
      #@twitterUser = @twitterUser + tweet.user.screen_name
      end
  end

  def twitterHandle
  end

  def twitterUser
  end

  def about
  end
end



