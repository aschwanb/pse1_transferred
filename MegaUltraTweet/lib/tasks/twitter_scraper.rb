require_relative '../../app/models/topics_start'
require_relative '../../app/models/twitter_client'
require_relative '../../app/models/tweet'
require_relative '../../app/models/tweet_parser'

# TODO: Run a new search the most popular (depth) hashtags for one entry
class TwitterScraper

  def initialize
    @client = TwitterClient.new
    @parser = TweetParser.new
    @providedSearches = 3
    @usedSearches = 0
  end

  def scrape(query, querySize, depth, detail)
    puts "Depth is at #{depth}"
    begin
      self.runQuery(query, querySize)
      puts query
      newQuery = self.getNewQuery(query, detail)
      # Save tweets and reset
      @client.getTweetsAsArray.each { |t| saveTweet(t) }
      @client.resetTweets
      # Start a new search with one less depth
       while depth > 1
         depth = depth - 1
         puts "Start new branch with #{newQuery}"
         scrape(newQuery, querySize, depth, detail)
       end
    rescue
      puts "Maximum searches for this time window used."
    end
    puts "Finished scraping for now"
  end

  def runQuery(query, querySize)
    while query.any? do
      localQuery = query.pop
      puts "Scraping for #{localQuery} ..."
      @client.simpleSearch(localQuery, querySize)
      @usedSearches = @usedSearches + 1
      if @providedSearches <= @usedSearches
        raise "Maximum searches for this time window used."
      end
    end
  end

  def getNewQuery(query, detail)
    # Get all new hashtags without the ones present in the last query
    newQuery = @client.getHashtagsAsHash
    query.each { |t| newQuery.delete(t.downcase) }
    # Determine how many of them to take
    newQuery = newQuery.first(detail).map(&:first).to_a
    return newQuery
  end

  def saveTweet(tweet)
    author = @parser.getAuthor(tweet)
    if Tweet.where(twitter_id: tweet.id).blank?
      t = author.tweets.create(
          text: tweet.text,
          retweets: tweet.retweet_count,
          twitter_id: tweet.id
      )
      t.addHashtags(@parser.parseHashtags(tweet))
    end
  end

end

