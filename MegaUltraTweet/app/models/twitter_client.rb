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

  # TODO: rename this maybe(search_twitter)? we have a simple_search method in db_search. Could lead to confusion.
  def search_simple(query, query_size)
    return @client.search(query, since: MegaUltraTweet::Application::TWEETS_SINCE_STRING).take(query_size).to_a
  end

  # TODO: Still used ? More than one search method necessary ?
  def search_since_id(query, query_size, min_id)
    return @client.search("#{query} AND since_id:#{min_id}", :result_type => "recent").take(query_size).to_a
  end

  def get_hashtags_to_h(tweets)
    return sort(@parser.parse_hashtags_a(tweets))
  end

  # TODO: Still used ?
  def get_twitterhandles_to_h(tweets)
    return sort(@parser.parse_twitterhandles_a(tweets))
  end

  def get_urls_to_h(tweets)
    return sort(@parser.parse_webpages_a(tweets))
  end

  # TODO: could be moved to sorter
  def sort(input)
    output = input.each_with_object(Hash.new(0)){ |tag, counts| counts[tag] += 1 }
    output = Hash[output.sort_by{ |tags, counts| counts}.reverse]
    return output
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
      t.set_hashtags(@parser.parse_hashtags(tweet)) unless @parser.parse_hashtags(tweet).nil?
      generate_hashtag_hashtag(t.get_hashtags)
      generate_author_hashtag(t.get_author, t.get_hashtags)
    end
  end

  def generate_hashtag_hashtag(hashtags)
    hashtags.sort_by! { |h| h.text }
    while !hashtags.blank?
      h_first = hashtags.pop
      hashtags.each do |h_second|
        if HashtagHashtag.where(hashtag_first: h_first, hashtag_second: h_second).blank?
          pair = HashtagHashtag.create(hashtag_first: h_first, hashtag_second: h_second)
          pair.create_popularity(times_used: [0])
        else
          pair = HashtagHashtag.find_by(hashtag_first: h_first, hashtag_second: h_second)
        end
        pair.set_rank(pair.get_rank + 1)
      end
    end
  end

  def generate_author_hashtag(author, hashtags)
    while !hashtags.blank?
      hashtag = hashtags.pop
      if AuthorHashtag.where(author: author, hashtag: hashtag).blank?
        pair = AuthorHashtag.create(author: author, hashtag: hashtag)
        pair.create_popularity(times_used: [0])
      else
        pair = AuthorHashtag.find_by(author: author, hashtag: hashtag)
      end
      pair.set_rank(pair.get_rank + 1)
    end
  end

  def delete_old_tweets
    Tweet.destroy_all(['created_at < ?', MegaUltraTweet::Application::DELETE_OLDER_TWEETS])
  end

  # TODO: This function is not currently used
  # If you intend on using it, make sure your app
  # has write access to your twitter account
  def post_message_on_twitter(message)
    @client.update(message)
  rescue Twitter::Error::Unauthorized => e
    Rails.logger.debug "DEBUG: Error in TwitterClient" if Rails.logger.debug?
    Rails.logger.debug "DEBUG: #{self.inspect} #{caller(0).first}" if Rails.logger.debug?
    Rails.logger.debug "DEBUG: #{e.message}" if Rails.logger.debug?
  end

end