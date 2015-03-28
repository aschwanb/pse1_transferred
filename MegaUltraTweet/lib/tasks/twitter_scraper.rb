require_relative '../../app/models/topics_start'
require_relative '../../app/models/twitter_client'
require_relative '../../app/models/tweet'
require_relative '../../app/models/tweet_parser'

# USAGE: Give an array of starting points, the number of objects per query and the desired depth
# The scraper should then run as cron-job, fetch tweets and write them to the database.
class TwitterScraper

  def initialize
    @client = TwitterClient.new
    @parser = TweetParser.new
    @providedSearches = 450
    @usedSearches = 0
  end

  def scrape(query, querySize, depth, detail)
    puts "Depth is at #{depth}"
    tmpQuery = query.clone
    while tmpQuery.any? do
      localQuery = tmpQuery.pop
      puts "Scraping for #{localQuery} ..."
      @client.simpleSearch(localQuery, querySize)
      @usedSearches = @usedSearches + 1
      if @providedSearches <= @usedSearches
        puts "Maximum searches for this time window used. Halting for now."
        exit
      end
    end
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
      t = author.tweets.create( text: tweet.text, retweets: tweet.retweet_count, twitter_id: tweet.id)
      t.addHashtags(@parser.parseHashtags(tweet))
    end
  end

end

