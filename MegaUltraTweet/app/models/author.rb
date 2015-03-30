class Author < ActiveRecord::Base
  has_many :tweets

  def getName
    return self.name
  end

  def getFriendsCount
    return self.friends_count
  end

  def getTweets
    return self.tweets.to_a
  end

  # TODO: Add followers_count
  # t.user.user.followers_count

  # TODO: Add screen_name = Twitter Handle
  # t.user.screen_name
end
