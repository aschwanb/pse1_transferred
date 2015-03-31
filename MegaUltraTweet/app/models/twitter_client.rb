require 'twitter'
require_relative 'tweet_parser'

class TwitterClient

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter_client_consumer_key
      config.consumer_secret     = Rails.application.secrets.twitter_client_consumer_secret
      config.access_token        = Rails.application.secrets.twitter_client_access_token
      config.access_token_secret = Rails.application.secrets.twitter_client_access_token_secret
    end
    @tweets = []
    @parser = TweetParser.new
  end
# TODO: Add combo search
  def search_simple(query, query_size)
    add_tweets(@client.search(query, :result_type => "recent").take(query_size).to_a)
  end

  def search_since_id(query, query_size, min_id)
    add_tweets(@client.search("#{query} AND since_id:#{min_id}", :result_type => "recent").take(query_size).to_a)
  end

  def add_tweets(tweets)
    tweets.each { |t| @tweets.push(t) }
  end

  def get_tweets_to_a
    return @tweets
  end

  def get_hashtags_to_h
    return sort(@parser.parse(@tweets, "Hashtags"))
  end

  def get_twitterhandles_to_h
    return sort(@parser.parse(@tweets, "TwitterHandles"))
  end

  def get_urls_to_h
    return sort(@parser.parse(@tweets, "URLs"))
  end

  def sort(input)
    output = input.each_with_object(Hash.new(0)){ |tag, counts| counts[tag] += 1 }
    output = Hash[output.sort_by{ |tags, counts| counts}.reverse]
    return output
  end

  def reset_tweets
    @tweets = []
  end

end