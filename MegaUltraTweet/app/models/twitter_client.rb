require 'twitter'

class TwitterClient
  # TODO: Extract Twitter Users

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter_client_consumer_key
      config.consumer_secret     = Rails.application.secrets.twitter_client_consumer_secret
      config.access_token        = Rails.application.secrets.twitter_client_access_token
      config.access_token_secret = Rails.application.secrets.twitter_client_access_token_secret
    end
    @tweets = []
  end

  def search(query, querySize)
    addTweets(@client.search(query, :result_type => "recent").take(querySize).to_a)
  end

  def addTweets(tweets)
    tweets.each { |t| @tweets.push(t) }
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

    if extractMe == "URLs"
      # Eliminate urls that are to short
      tmp.each { |url| tmp.delete(url) if url.length < 10 }
    end
    return tmp
  end

end