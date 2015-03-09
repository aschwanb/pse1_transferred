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

  def finde
    @query = params[:query]
    if !@query.blank?
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
      @tweets = client.search(@query, :result_type => "recent").take(10).collect
      @tweets.each do |tweet|
        # Extract hashtag from tweet
        @hashtags = @hashtags + tweet.text.scan(/#\w+/).flatten
        @twitterHandles = @twitterHandles + tweet.text.scan(/@\w+/).flatten
        @webpages = @webpages + URI.extract("#{tweet.text}", /http|https/)
        #@twitterUser = @twitterUser + tweet.user.screen_name
      end
      # Eliminate dublications and sort
      @hashtags = @hashtags.uniq.sort_by{|word| word.downcase}
      @twitterHandles = @twitterHandles.uniq.sort_by{|word| word.downcase}
      @webpages = @webpages.uniq.sort_by{|word| word.downcase}
      # Eliminate urls that are to short
      @webpages.each { |url| @webpages.delete(url) if url.length < 10 }
    end
  end

  def twitterHandle
  end

  def twitterUser
  end

  def about
  end
end



