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
    return Tweet.take(5)
  end

  def fetch_trending_short
    return Trending.first.get_popular_short
  end

  def fetch_trending_long
    return Trending.second.get_popular_long
  end
end