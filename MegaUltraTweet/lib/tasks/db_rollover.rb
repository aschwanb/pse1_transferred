class DBRollover
  # Cronjob. Run to clean db.

  def initialize
    @startingpoint = Startingpoint.first
    @scraper = TwitterScraper.new(
        MegaUltraTweet::Application::GET_THIS_MANY,
        MegaUltraTweet::Application::QUERY_DETAIL
        )
    @client = TwitterClient.new
    @trending = Trending.first
  end

  # TODO: Rescue nil class error
  def short_rollover
    reset_startingpoint
    update_popularities
    set_new_short(false)
    @client.delete_old_tweets
    @scraper.get_tweets(
        @startingpoint.get_start,
        MegaUltraTweet::Application::QUERY_DEPTH
        )
    @trending.build_new
  end

  def long_rollover
    set_new_long(false)
  end

  def reset_startingpoint
    @startingpoint.add_popular_hashtags(MegaUltraTweet::Application::HASHTAG_TO_START_NUMBER)
    @startingpoint.remove_unpopular_hashtags(MegaUltraTweet::Application::HASHTAG_TO_START_NUMBER)
    @startingpoint.repair_defaults
  end

  def update_popularities
    Popularity.all.each { |p| p.add_new}
  end

  def set_new_short(bool)
    AuthorHashtag.where(new_short: true).all.each { |ah| ah.set_new_short(bool) }
    HashtagHashtag.where(new_short: true).all.each { |hh| hh.set_new_short(bool) }
  end

  def set_new_long(bool)
    AuthorHashtag.where(new_long: true).all.each { |ah| ah.set_new_long(bool) }
    HashtagHashtag.where(new_long: true).all.each { |hh| hh.set_new_long(bool) }
  end

end