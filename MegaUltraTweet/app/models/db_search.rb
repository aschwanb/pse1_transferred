require 'search_object'
class DbSearch
  def parse_query(query)
    query = query.to_s.downcase
    hashtags = query.scan(/#\w+/).flatten
    authors = query.scan(/@\w+/).flatten
    search_terms = hashtags + authors
    search_object = SearchObject.new(search_terms)
    dbe_hashtag = []
    dbe_hashtag.append(Hashtag.find_by_text(hashtags[0]))

    if !dbe_hashtag.first.nil?
      search_object.set_hashtags(dbe_hashtag)
      search_object.set_tweets(dbe_hashtag.first.get_tweets)
      search_object.set_search_successful
    end

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

    return search_object
  end
end