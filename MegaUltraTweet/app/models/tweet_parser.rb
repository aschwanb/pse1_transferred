class TweetParser

  def initialize
  end

  # TODO: Refactor this!
  # Performance-wise, it is worse then hell
  def parse(tweets, type)
    tmp = []
    tweets.each do |tweet|
      case type
        when "Hashtags"
          tmp = tmp + tweet.text.downcase.scan(/#\w+/).flatten
        when "TwitterHandles"
          tmp = tmp + tweet.text.downcase.scan(/@\w+/).flatten
        when "URLs"
          tmp = tmp + URI.extract("#{tweet.text}", /http|https/)
          if !(tmp.nil? or tmp.empty?) and !tmp.last.match(/[[:alnum:]]$/) #regex: last char is alphabetic or numeric
            tmp.pop
          end
        else
          puts "Invalide parameter"
      end
    end

    if type == "URLs"
      # Eliminate urls that are to short
      tmp.each { |url| tmp.delete(url) if url.length < 10 }
    end
    return tmp
  end

  def parseHashtags(tweet)
    return tweet.text.downcase.scan(/#\w+/).flatten
  end

  def parseTwitterHandles(tweet)
    return tweet.text.downcase.scan(/@\w+/).flatten
  end

  def parseWebpages(tweet)
    tmp = []
    tmp = tmp + URI.extract("#{tweet.text}", /http|https/)
    if !(tmp.nil? or tmp.empty?) and !tmp.last.match(/[[:alnum:]]$/) #regex: last char is alphabetic or numeric
      tmp.pop
    end
    # Eliminate urls that are to short
    tmp.each { |url| tmp.delete(url) if url.length < 10 }
    return tmp
  end

  def getAuthor(tweet)
    # TODO: Author is not currently being updated
    if Author.where(twitter_id: tweet.user.id).blank?
      return Author.create(
          name: tweet.user.name,
          friends_count: tweet.user.friends_count,
          twitter_id: tweet.user.id,
          followers_count: tweet.user.followers_count,
          screen_name: tweet.user.screen_name
          )
    else
      return Author.find_by_screen_name(tweet.user.screen_name)
    end
  end

  def getTwitterId(tweet)
    return tweet.id
  end

end