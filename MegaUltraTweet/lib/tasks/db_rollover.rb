class DBRollover
  # Cronjob. Run to clean db.

  def initialize
    @hashtag_nr = 10 # Amount of hashtags to add to startingpoint
  end

  # The following items have a value for popularity:
  # Hashtag
  # Hashtag Pairs
  #

  def reset_startingpoint
    # Use standard set of hashtags
    # Add most popular tags / authors / ...
    Hashtag.order(:popularity_now).last(@hashtag_nr).each do |hashtag|
      if !Startingpoint.first.hashtags.include?(hashtag)
        Startingpoint.first.hashtags<<hashtag
      end
    end

  end
  
  # TODO: Clean db. Remove old tweets ?
  # If so, what happens with old authors, hashtags ... ?
end