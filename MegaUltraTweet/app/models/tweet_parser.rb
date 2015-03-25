class TweetParser

  # TODO: Performance-wise, this is worse then hell
  def parse(extractMe)
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