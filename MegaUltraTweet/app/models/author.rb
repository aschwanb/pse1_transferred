class Author < ActiveRecord::Base
  has_many :tweets

  def get_name
    return self.name
  end

  def get_friends_count
    return self.friends_count
  end

  def get_tweets
    return self.tweets.to_a
  end

end
