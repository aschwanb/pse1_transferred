class SearchObject
  @@searched_for = []
  @@tweets

  def initialize(query)
    @@searched_for = query
  end

  def addTweets(tweets)
    @@tweets = tweets
  end

  def getSearchedFor
    return @@searched_for
  end
end