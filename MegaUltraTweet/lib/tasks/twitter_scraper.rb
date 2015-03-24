require_relative '../../app/models/topics_start'
require_relative '../../app/models/twitter_client'
# USAGE: Give an array of starting points, the number of objects per query and the desired depth
# The scraper should then run as chron-job, fetch tweets and write them to the database.
class TwitterScraper

  def initialize
  end

  def scrape(query, querySize, depth, detail)
    puts "Depth is at #{depth}"
    twitterClient = TwitterClient.new
    tmpQuery = query.clone
    while tmpQuery.any? do
      localQuery = tmpQuery.pop
      puts "Scraping for #{localQuery}"
      twitterClient.search(localQuery, querySize)
    end
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



end

# topics = TopicsStart.new.getTopics
# twitterScraper = TwitterScraper.new
# twitterScraper.scrape(%w[#Technology #iWatch #Trending], 2, 5, 3)
