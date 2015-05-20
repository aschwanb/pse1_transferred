class Author < ActiveRecord::Base
  has_many :tweets
  has_many :author_hashtags

   validates :name, :screen_name, :twitter_id, :friends_count,
            :followers_count, presence: true

  scope :by_screen_name, -> (screen_name) { where screen_name: screen_name}

  def update_all(name, friends_count, followers_count, screen_name)
    self.update(name: name) unless self.name == name
    self.update(friends_count: friends_count) unless self.friends_count == friends_count
    self.update(followers_count: followers_count) unless self.followers_count == followers_count
    self.update(screen_name: screen_name) unless self.screen_name == screen_name
  end

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

  def get_rank
    return get_followers_count
  end

end
