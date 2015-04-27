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
    puts "Reset Startingpoint"
    reset_startingpoint
    puts "Update Popularities"
    update_popularities
    @scraper.get_tweets(@startingpoint.get_start, @query_depth)
    @trending.build_new
  end

  def reset_startingpoint
    @startingpoint.add_popular_hashtags(@hashtag_nr)
    @startingpoint.remove_unpopular_hashtags(@hashtag_nr)
    # TODO: Re-add standard hashtags if not present
  end

  def update_popularities
    Popularity.all.each { |p| p.add_new}
  end

  # TODO: Clean db. Remove old tweets ?
  # TODO: Small rollover for 15 min interval and statistics. Big rollover every 48 hours?

end