require 'search_object'
class DbSearch
  def parseQuery(query)
    query = query.to_s.downcase
    hashtags = query.scan(/#\w+/).flatten
    authors = query.scan(/@\w+/).flatten
    searchTerms = hashtags + authors
    searchObj = SearchObject.new(searchTerms)
    dbe_hashtag = []
    dbe_hashtag.append(Hashtag.find_by_text(hashtags[0]).text)
    searchObj.setHashtags(dbe_hashtag)

    # if hashtags.length == 1
    #   sobj = SearchObject.new(hashtags)
    #   hashtag_id = Hashtag.find_by_text(hashtags[0]).id
    #   tweets = Tweet.joins(:hashtags_tweets).where(hashtag_id: hashtag_id)
    #   tweet_text = []
    #   tweets.find_each do |tweet|
    #     tweet_text += tweet.text
    #   end
    #   sobj.addTweets(tweet_text)
    # end
    return searchObj
  end
end