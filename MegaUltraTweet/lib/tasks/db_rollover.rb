class DBRollover
  # Cronjob. Run to clean db.

  def initialize
    @startingpoint = Startingpoint.first
    @scraper = TwitterScraper.new(
        MegaUltraTweet::Application::GET_THIS_MANY,
        MegaUltraTweet::Application::QUERY_DETAIL
        )
    @trending = Trending.first
  end

  def rollover
    reset_startingpoint
    update_popularities
    @scraper.delete_old_tweets
    @scraper.get_tweets(
        @startingpoint.get_start,
        MegaUltraTweet::Application::QUERY_DEPTH
        )
    @trending.build_new
  end

  def reset_startingpoint
    @startingpoint.add_popular_hashtags(MegaUltraTweet::Application::HASHTAG_TO_START_NUMBER)
    @startingpoint.remove_unpopular_hashtags(MegaUltraTweet::Application::HASHTAG_TO_START_NUMBER)
    @startingpoint.repair_defaults
  end

  def update_popularities
    Popularity.all.each { |p| p.add_new}
  end

end