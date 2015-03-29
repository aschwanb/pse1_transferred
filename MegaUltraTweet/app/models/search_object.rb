class SearchObject
  @searchTerms = []
  @tweets

  def initialize(query)
    @searched_for = query
  end

  def addTweets(tweets)
    @tweets = tweets
  end

  def getSearchTerms
    return @searchTerms
  end
end