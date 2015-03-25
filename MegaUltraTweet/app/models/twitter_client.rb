require 'twitter'
require_relative 'tweet_parser'

class TwitterClient
  # TODO: Extract Twitter Users

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

  def search(query, querySize)
    addTweets(@client.search(query, :result_type => "recent").take(querySize).to_a)
  end

  def addTweets(tweets)
    tweets.each { |t| @tweets.push(t) }
  end

  def getTweetsAsArray
    return @tweets
  end

  def getHashtagsAsHash
    return sort(@parser.parse("Hashtags"))
  end

  def getTwitterHandlesAsHash
    return sort(@parser.parse("TwitterHandles"))
  end

  def getURLsAsHash
    return sort(@parser.parse("URLs"))
  end

  def sort(input)
    output = input.each_with_object(Hash.new(0)){ |tag,counts| counts[tag] += 1 }
    output = Hash[output.sort_by{ |tags, counts| counts}.reverse]
    return output
  end

  def resetTweets
    @tweets = []
  end

end