class TwitterClient
  # TODO: Extract Twitter Users

  def initialize(querySize, query)
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "tTrNPGMT8S1d3qK3LMlnZV1XP"
      config.consumer_secret     = "olUHmGtYlh6dx3ztWqa6ExLLek7Vb76vGEi5p5BMd2LiFWWHPD"
      config.access_token        = "3062227378-HaWeilWyykpsDQvwZmaGUUSHDmlOFlHxpHpC9RY"
      config.access_token_secret = "etP0a6eCI0q1FwfMJYUO0VsTWyrhbYKRvuvUS8YKH2kC3"
    end
    @querySize = querySize
    @query = query
    @tweets = search
  end

  def search
    return @client.search(@query, :result_type => "recent").take(@querySize).collect
  end

  def getTweets
    return @tweets
  end

  def getHashtags
    return sort(extractFromTweet("Hashtags"))
  end

  def getTwitterHandles
    return sort(extractFromTweet("TwitterHandles"))
  end

  def getURLs
    return sort(extractFromTweet("URLs"))
  end

  def sort(input)
    output = input.each_with_object(Hash.new(0)){ |tag,counts| counts[tag] += 1 }
    output = Hash[output.sort_by{ |tags, counts| counts}.reverse]
    return output
  end

  # TODO: Performance-wise, this is worse then hell
  def extractFromTweet(extractMe)
    tmp = []
    @tweets.each do |tweet|
      case extractMe
        when "Hashtags"
          tmp = tmp + tweet.text.downcase.scan(/#\w+/).flatten
        when "TwitterHandles"
          tmp = tmp + tweet.text.scan(/#@\w+/).flatten
        when "URLs"
          tmp = tmp + URI.extract("#{tweet.text}", /http|https/)
          unless tmp.nil? and tmp.last.match(/[[:alnum:]]/) #regex: last char is alphabetic or numeric
            tmp.pop
          end
        else
          puts "Invalide parameter"
      end
    end

    if extractMe == "URLs"
      # Eliminate urls that are to short
      tmp.each { |url| tmp.delete(url) if url.length < 10 }
    end
    return tmp
  end

end