class DbentryFetcher

  def initialize
  end

  def fetchHashtags
    return Hashtag.take(5)
  end

  def fetchAuthors
    return Author.take(20)
  end

  def fetchTweets
    return Tweet.take(20)
  end

end