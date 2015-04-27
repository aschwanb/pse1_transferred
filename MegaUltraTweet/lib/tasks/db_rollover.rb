class DBRollover
  # Cronjob. Run to clean db.

  def initialize
    # TODO: Move numbers to config file
    @hashtag_nr = 10 # Amount of hashtags to add to startingpoint
    @query_depth = 5
    @startingpoint = Startingpoint.first
    @scraper = TwitterScraper.new(400, 10)
    @trending = Trending.first
  end

  def rollover
    reset_startingpoint
    update_popularities
    # TODO: Remove tweets older then n iterations
    @scraper.get_tweets(@startingpoint.get_start, @query_depth)
    @trending.build_new
  end

  def reset_startingpoint
    @startingpoint.add_popular_hashtags(@hashtag_nr)
    @startingpoint.remove_unpopular_hashtags(@hashtag_nr)
    @startingpoint.repair_defaults
  end

  def update_popularities
    Popularity.all.each { |p| p.add_new}
  end

end