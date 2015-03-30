class Sorter

  def sortTweetsByRank(tweets)
    #Returns array in which tweets are sorted by popularity (Descending)
    tweets.sort_by! {|tweet| tweet.getRank}
    return tweets.reverse!
  end
end