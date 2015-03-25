class TweetParser

  def initialize
  end

  # TODO: Performance-wise, this is worse then hell
  def parse(tweets, type)
    puts "Hello From parser"
    tmp = []
    tweets.each do |tweet|
      case type
        when type == "Hashtags"
          tmp = tmp + tweet.text.downcase.scan(/#\w+/).flatten
        when type == "TwitterHandles"
          tmp = tmp + tweet.text.downcase.scan(/@\w+/).flatten
        when type == "URLs"
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

end