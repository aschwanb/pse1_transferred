class DBRollover
  # Cronjob. Run to clean db.

  def initialize
    @hashtag_nr = 10 # Amount of hashtags to add to startingpoint
    @query_depth = 5
    @startingpoint = Startingpoint.first
    @scraper = TwitterScraper.new(400, 10)
  end

  def rollover
    reset_startingpoint
    @scraper.get_tweets(@startingpoint.get_start, @query_depth)
    # build trending table with most changes
    build_trending
    update_popularities
  end

  def reset_startingpoint
    # Add most popular tags
    # add_hashtags
    # Remove most unpopular tags
    # remove_hashtags
    # Re-add standard hashtags if not present
  end

  def build_trending
    # TODO
  end

  def add_hashtags
    hashtags = Hashtag.all
    hashtags = hashtags.sort_by{ |hashtag| hashtag.get_popularity_now }.reverse
    hashtags.first(@hashtag_nr).each do |hashtag|
      if !@startingpoint.hashtags.include?(hashtag)
        @startingpoint.hashtags<<hashtag
      end
    end
  end

  def remove_hashtags
    hashtags = @startingpoint.hashtags
  end

  def update_popularities
    Popularity.all.each { |p| p.add_new}
  end
  # TODO: Clean db. Remove old tweets ?
  # If so, what happens with old authors, hashtags ... ?

  # TODO: Small rollover for 15 min interval and statistics. Big rollover every 48 hours?
end