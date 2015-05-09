class TweetParser

  # Returns hashtag strings (not objects) as array
  def parse_hashtags_a(tweets)
    tmp = []
    tweets.each { |t| tmp += parse_hashtags(t) }
    return tmp
  end

  # Returns twitterhandle strings (not objects) as array
  # TODO: Still used ?
  def parse_twitterhandles_a(tweets)
    tmp = []
    tweets.each { |t| tmp += parse_twitterhandles(t) }
    return tmp
  end

  # Returns urls (not objects)as array
  def parse_webpages_a(tweets)
    tmp = []
    tweets.each { |t| tmp += parse_webpages(t) }
    return tmp
  end

  # TODO: Create hashtag objects here
  def parse_hashtags(tweet)
    return tweet.text.downcase.scan(/#\w+/).flatten
  end

  # TODO: Still used ?
  def parse_twitterhandles(tweet)
    return tweet.text.downcase.scan(/@\w+/).flatten
  end

  # TODO: Create webpage objects here
  def parse_webpages(tweet)
    tmp = []
    tmp = tmp + URI.extract("#{tweet.text}", /http|https/)
    if !(tmp.nil? or tmp.empty?) and !tmp.last.match(/[[:alnum:]]$/) # regex: last char is alphabetic or numeric
      tmp.pop
    end
    # Eliminate urls that are to short
    tmp.each { |url| tmp.delete(url) if url.length < 10 }
    return tmp
  end

  def get_author(tweet)
    if Author.where(twitter_id: tweet.user.id).blank?
      author =  Author.create(
              name: tweet.user.name,
              friends_count: tweet.user.friends_count,
              twitter_id: tweet.user.id,
              followers_count: tweet.user.followers_count,
              screen_name: tweet.user.screen_name
            )
    else
      author = Author.find_by_screen_name(tweet.user.screen_name)
      author.update_all(
          tweet.user.name,
          tweet.user.friends_count,
          tweet.user.followers_count,
          tweet.user.screen_name
      )
    end
    return author
  end

  def get_twitter_id(tweet)
    return tweet.id
  end

end