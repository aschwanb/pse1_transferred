class SearchObject
  @searchTerms = []
  @tweets

  def initialize(query)
    @searchTerms = query
  end

  def addTweets(tweets)
    @tweets = tweets
  end

  def getSearchTerms
    return @searchTerms
  end
end