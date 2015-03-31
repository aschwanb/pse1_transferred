require_relative '../../app/models/twitter_client'
require_relative '../../app/models/tweet'
require_relative '../../app/models/tweet_parser'

# TODO: Run a new search the most popular (depth) hashtags for one entry
class TwitterScraper

  def initialize
    @client = TwitterClient.new
    @parser = TweetParser.new
    @providedSearches = 450
    @usedSearches = 0
  end

  def scrape(query, querySize, depth, detail)
    puts "Depth is at #{depth}"
    begin
      self.run_query(query, querySize)
      puts query
      newQuery = self.get_new_query(query, detail)
      # Save tweets and reset
      @client.get_tweets_to_a.each { |t| save_tweet(t) }
      @client.reset_tweets
      # Start a new search with one less depth
       while depth > 1
         depth = depth - 1
         puts "Start new branch with #{newQuery}"
         scrape(newQuery, querySize, depth, detail)
       end
    #rescue
    #  puts "Maximum searches for this time window used."
    end
    puts "Finished scraping for now"
  end

  def run_query(query, querySize)
    while query.any? do
      localQuery = query.pop
      puts "Scraping for #{localQuery} ..."
      @client.search_simple(localQuery, querySize)
      @usedSearches = @usedSearches + 1
      puts "Used searches #{@usedSearches}"
      puts "Provided searches #{@providedSearches}"
      if @providedSearches <= @usedSearches
        raise
      end
    end
  end

  def get_new_query(query, detail)
    # Get all new hashtags without the ones present in the last query
    newQuery = @client.get_hashtags_to_h
    query.each { |t| newQuery.delete(t.downcase) }
    # Determine how many of them to take
    newQuery = newQuery.first(detail).map(&:first).to_a
    return newQuery
  end

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

