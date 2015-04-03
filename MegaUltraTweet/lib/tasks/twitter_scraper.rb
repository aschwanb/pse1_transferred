require_relative '../../app/models/twitter_client'
require_relative '../../app/models/tweet'
require_relative '../../app/models/tweet_parser'

# TODO: Run a new search the most popular (depth) hashtags for one entry
class TwitterScraper

  def initialize
    @client = TwitterClient.new
    @parser = TweetParser.new
    @provided_searches = 450
    @used_searches = 0
  end

  # Scraping for a array of key words
  def scrape(query, query_size, depth, detail)
    # puts "Depth is at #{depth}"
    if depth > 0
      begin
        self.run_query(query, query_size)
        new_query = self.get_new_query(query, detail)
        self.save_and_reset
        # Start a new search with one less depth
        depth = depth - 1
        puts "Start new branch with #{new_query}"
        scrape(new_query, query_size, depth, detail)
      rescue
        puts "Maximum searches for this time window used."
      end
    else
      puts "Finished scraping for now"
    end
  end

  # TODO: Scraper for individual key words
  # As before, but take the n most popular hashtags for each key word



  def run_query(query, querySize)
    while query.any? do
      local_query = query.pop
      puts "Scraping for #{local_query} ..."
      @client.search_simple(local_query, querySize)
      @used_searches = @used_searches + 1
      puts "Used searches #{@used_searches}"
      puts "Provided searches #{@provided_searches}"
      if @provided_searches <= @used_searches
        raise
      end
    end
  end

  def get_new_query(query, detail)
    # Get all new hashtags without the ones present in the last query
    new_query = @client.get_hashtags_to_h
    query.each { |t| new_query.delete(t.downcase) }
    # Determine how many of them to take
    new_query = new_query.first(detail).map(&:first).to_a
    return new_query
  end

  def save_and_reset
    @client.get_tweets_to_a.each { |t| save_tweet(t) }
    @client.reset_tweets
  end
  # TODO: Move to TwitterClient
  def save_tweet(tweet)
     author = @parser.get_author(tweet)
     if Tweet.where(twitter_id: tweet.id).blank?
        t = author.tweets.create(
          text: tweet.text,
          retweets: tweet.retweet_count,
          twitter_id: tweet.id
        )
      t.set_hashtags(@parser.parse_hashtags(tweet))
      t.set_webpages(@parser.parse_webpages(tweet))
    end
  end

end

