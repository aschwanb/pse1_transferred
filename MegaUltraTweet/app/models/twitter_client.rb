require 'twitter'

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
    tmp = []
    @tweets.each do |tweet|
      tmp = tmp + tweet.text.scan(/#\w+/).flatten
    end
    return sort(tmp)
  end

  def getTwitterHandles
    tmp = []
    @tweets.each do |tweet|
      tmp = tmp + tweet.text.scan(/#@\w+/).flatten
    end
    return sort(tmp)
  end

  def getURLs
    tmp = []
    @tweets.each do |tweet|
      tmp = tmp + URI.extract("#{tweet.text}", /http|https/)
    end
    # Eliminate urls that are to short
    tmp.each { |url| tmp.delete(url) if url.length < 10 }
    return sort(tmp)
  end


  def sort(input)
    output = input.each_with_object(Hash.new(0)){ |tag,counts| counts[tag] += 1 }
    output = Hash[output.sort_by{ |tags, counts| counts}.reverse]
    return output
  end

end