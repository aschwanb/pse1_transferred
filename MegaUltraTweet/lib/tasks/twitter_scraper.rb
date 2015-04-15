require_relative '../../app/models/twitter_client'
require_relative '../../app/models/tweet'
require_relative '../../app/models/tweet_parser'

class TwitterScraper

  def initialize(query_size, detail)
    @client = TwitterClient.new
    @parser = TweetParser.new
    @provided_searches = 400  # Add some buffer for user input. Max searches is at 450
    @used_searches = 0
    @query_size = query_size  # How many results do we request from twitter
    @detail = detail  # How many of the most relevant keywords do we follow up on ?
  end

  # Scraping for a array of key words
  def start(query, depth)
    Array(query).each { |keyword| scrape(keyword, depth) }
  end

  # Scraping for a keyword. Start a new searches with one less depth
  def scrape(keyword, depth)
    tweets = run_query(keyword)
    tweets.each { |t| @client.save_tweet(t) }
    new_query = self.get_new_query(keyword, tweets)
    depth -= 1
    if depth > 0
      puts "Finished with #{keyword}. Start new branch with #{new_query}"
      start(new_query, depth)
    end
  rescue Exceptions::MaxSearchesError => e
    puts e.message
  rescue Twitter::Error => e
    puts e.message
  end

  def run_query(keyword)
    puts "Scraping for \"#{keyword}\" ..."
    if @provided_searches == @used_searches
      raise Exceptions::MaxSearchesError.new, "Maximum searches for this time window used."
    end
    @used_searches = @used_searches + 1
    @client.search_simple(keyword, @query_size)
  end

  # Returns the "detail" most relevant keywords - without the one present in the last query
  def get_new_query(keyword, tweets)
    new_query = @client.get_hashtags_to_h(tweets)
    new_query.delete(keyword.downcase)
    return new_query.first(@detail).map(&:first).to_a
  end

end

