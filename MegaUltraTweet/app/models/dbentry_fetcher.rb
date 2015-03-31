class DbentryFetcher

  def initialize
  end

  def fetch_hashtags
    return Hashtag.take(20)
  end

  def fetch_authors
    return Author.take(20)
  end

  def fetch_tweets
    return Tweet.take(20)
  end

end