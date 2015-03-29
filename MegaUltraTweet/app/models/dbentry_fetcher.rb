class DbentryFetcher

  def initialize
  end

  def fetchHasthtags
    return Hashtag.take(20)
  end

  def fetchAuthors
    return Authors.take(20)
  end

  def fetchTweets
    return Tweet.take(20)
  end

end