class DBRollover

  def initialize
    @startingpoint = Startingpoint.first
    @scraper = TwitterScraper.new(
        MegaUltraTweet::Application::GET_THIS_MANY,
        MegaUltraTweet::Application::QUERY_DETAIL
        )
    @client = TwitterClient.new
    @trending_short = Trending.first
    @trending_long = Trending.second
  end

  # Run as cronjob
  def short_rollover
    reset_startingpoint
    update_popularities
    set_new_short(false)
    @client.delete_old_tweets
    # TODO: Delete old popularity entries if array to long ?
    # TODO: Delete old links depending on last updated
    @scraper.get_tweets(
        @startingpoint.get_start,
        MegaUltraTweet::Application::QUERY_DEPTH
        )
    @trending_short.build_new_short
    @trending_long.build_new_long
  rescue NoMethodError => e
    Rails.logger.debug "DEBUG: Error during rollover" if Rails.logger.debug?
    Rails.logger.debug "DEBUG: #{self.inspect} #{caller(0).first}" if Rails.logger.debug?
    Rails.logger.debug "DEBUG: #{e.message}" if Rails.logger.debug?
  end

  # Run as cronjob
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