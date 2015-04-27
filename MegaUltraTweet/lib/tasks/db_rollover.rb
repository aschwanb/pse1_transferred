class DBRollover
  # Cronjob. Run to clean db.

  def initialize
    @hashtag_nr = 10 # Amount of hashtags to add to startingpoint
    @startingpoint = Startingpoint.first
  end

  # The following items have a value for popularity:
  # Hashtag
  # Hashtag Pairs
  # Author Hashtag Pairs

  def reset_startingpoint
    # Use standard set of hashtags
    # Add most popular tags / authors / ...
    # add_hashtags
    # Remove most unpopular tags / authors / ...
    # remove_hashtags
    update_popularities

  end

  def add_hashtags
    hashtags = Hashtag.all
    hashtags = hashtags.sort_by{ |hashtag| hashtag.get_popularity_now }.reverse
    hashtags.first(@hashtag_nr).each do |hashtag|
      # Hashtag.order(:popularity_now).last(@hashtag_nr).each do |hashtag|
      if !@startingpoint.hashtags.include?(hashtag)
        @startingpoint.hashtags<<hashtag
      end
    end
  end

  def remove_hashtags
    hashtags = @startingpoint.hashtags

  end

  def update_popularities
    Popularity.all.each { |p| p.rollover}
  end
  # TODO: Clean db. Remove old tweets ?
  # If so, what happens with old authors, hashtags ... ?

  # TODO: Small rollover for 15 min interval and statistics. Big rollover every 48 hours?
end