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
  end

  def scrape(query, querySize, depth, detail)
    puts "Depth is at #{depth}"
    tmpQuery = query.clone
    while tmpQuery.any? do
      localQuery = tmpQuery.pop
      puts "Scraping for #{localQuery} ..."
      @client.search(localQuery, querySize)
      puts "Done scraping"
    end
    # Save all the tweets
    puts "Saving tweets"
    @client.getTweetsAsArray.each { |t| self.saveTweet(t) }
    puts "Done saving tweets"
    # All tweets are saved in twitterClient.getTweets
    # Get all new hashtags without the ones present in the last query
    newQuery = twitterClient.getHashtagsAsHash
    query.each { |t| newQuery.delete(t.downcase) }
    puts newQuery
    # Determine how many of them to take
    newQuery = newQuery.first(detail).map(&:first).to_a
    # Start a new search with one less depth
    while depth > 1
       depth = depth - 1
       puts "Start new branch with #{newQuery}"
       scrape(newQuery, querySize, depth, detail)
    end
    # Do not exceed query limit set by twitter
    # TODO
  end

  # Run for every tweet to save in db
  def saveTweet(tweet)
    # Check if author is allready present in db
    if Author.where(name: tweet.user.name).blank?
      author = @parser.getAuthor(tweet)
      author.save
    else
      author = Author.where(name: tweet.user.name)
    end
    puts "Initializing Tweet object"
    t = Tweet.new(
                 text: tweet.text,
                 retweets: tweet.retweet_count
    )
    puts "Basic object set up"
    t.author<<author
    puts "Parsing Hashtags for tweet:"
    p tweet.text
    tmp = @parser.parseHashtags(tweet)
    puts "Parsing resulted in the following tags: "
    p tmp
    puts "Add tags to tweet"
    tmp.each do |tag|
      if Hashtag.where(text: tag).blank?
        hashtag = Hashtag.create(text: tag)
        hashtag.save
      else
        hashtag = Hashtag.where(text: tag)
      end
      t.hashtags<<hashtag
    end
    puts "Start saving"
    t.save
  end

end

