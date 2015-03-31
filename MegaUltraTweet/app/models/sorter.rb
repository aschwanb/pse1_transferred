class Sorter

  def sort_tweets_by_rank(tweets)
    #Returns array in which tweets are sorted by popularity (Descending)
    tweets.sort_by! {|tweet| tweet.get_rank}
    return tweets.reverse!
  end
end