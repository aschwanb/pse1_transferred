require 'twitter'
require_relative 'tweet_parser'

class TwitterClient

  def initialize
    @parser = TweetParser.new
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter_client_consumer_key
      config.consumer_secret     = Rails.application.secrets.twitter_client_consumer_secret
      config.access_token        = Rails.application.secrets.twitter_client_access_token
      config.access_token_secret = Rails.application.secrets.twitter_client_access_token_secret
    end
  end

  def search_simple(query, query_size)
    return @client.search(query, :result_type => "recent").take(query_size).to_a
  end

  def search_since_id(query, query_size, min_id)
    return @client.search("#{query} AND since_id:#{min_id}", :result_type => "recent").take(query_size).to_a
  end

  def get_hashtags_to_h(tweets)
    return sort(@parser.parse_hashtags_a(tweets))
  end

  def get_twitterhandles_to_h(tweets)
    return sort(@parser.parse_twitterhandles_a(tweets))
  end

  def get_urls_to_h(tweets)
    return sort(@parser.parse_webpages_a(tweets))
  end

  def sort(input)
    output = input.each_with_object(Hash.new(0)){ |tag, counts| counts[tag] += 1 }
    output = Hash[output.sort_by{ |tags, counts| counts}.reverse]
    return output
  end

  def reset_tweets
    @tweets = []
  end

  def save_tweet(tweet)
    author = @parser.get_author(tweet)
    if Tweet.where(twitter_id: tweet.id).blank?
      t = author.tweets.create(
          text: tweet.text,
          retweets: tweet.retweet_count,
          twitter_id: tweet.id
      )
      t.set_webpages(@parser.parse_webpages(tweet))
      t.set_hashtags(@parser.parse_hashtags(tweet))

      # TODO: Move hashtag pair logic here

      # Loop through all combinations of pairs in hashtag array
      # Achtung: Sind nur Strings, keine Hashtags
      # Hashtags zuerst nach alphabet sortieren?
      hashtags_array = t.get_hashtags
      case hashtag_two
        when HashtagPair.where(hashtag_first: hashtag, hashtag_second: hashtag_two).blank? && HashtagPair.where(hashtag_first: hashtag_two, hashtag_second: hashtag).blank?
          # Pair does not exist
          pair = HashtagPair.create(
              hashtag_first: hashtag,
              hashtag_second: hasthatag_two,
              popularity_now: 0,
              popularity_old: 0
          )
        when !HashtagPair.where(hashtag_first: hashtag, hashtag_second: hashtag_two).blank?
          # Pair exists. Update Popularity
          pair = HashtagPair.find_by(hashtag_first: hashtag, hashtag_second: hashtag_two)
        when !HashtagPair.where(hashtag_first: hashtag_two, hashtag_second: hashtag).blank?
          # Pair exists. Update Popularity
          pair = HashtagPair.find_by(hashtag_first: hashtag_two, hashtag_second: hashtag)
      end
      pair.update(popularity_now: pair.get_popularity_now + 1)


    end
  end

end