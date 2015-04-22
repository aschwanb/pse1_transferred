class Author < ActiveRecord::Base
  has_many :tweets

  scope :by_screen_name, -> (screen_name) { where screen_name: screen_name}

  def get_name
    return self.name
  end

  def get_friends_count
    return self.friends_count
  end

  def get_followers_count
    return self.followers_count
  end

  def get_tweets(*args)
    return self.tweets.to_a if args.size > 1 || args.size < 1
    return self.tweets.take(args[0]).to_a
  end

  # values may not be adequate
  def get_rank
    return get_followers_count
  end

end
