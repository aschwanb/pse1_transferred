require 'addressable/uri'

class TweetParser

  # Returns hashtag strings (not objects) as array
  def parse_hashtags_a(tweets)
    tmp = []
    tweets.each { |t| tmp += parse_hashtags(t) }
    return tmp
  end

  # TODO: Still used ?
  # Returns twitterhandle strings (not objects) as array
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

  def parse_hashtags(tweet)
    return tweet.text.downcase.scan(/#\w+/).flatten
  end

  # TODO: Still used ?
  def parse_twitterhandles(tweet)
    return tweet.text.downcase.scan(/@\w+/).flatten
  end

  def parse_webpages(tweet)
    tmp = []
    tmp = tmp + URI.extract("#{tweet.text}", /http|https/)
    tmp = delete_endpoint(tmp)
    # Eliminates cut off URLs
    tmp.delete_if {|url| !url.last.match(/[[:alnum:]]$/)}# regex: last char is alphabetic or numeric
    # Eliminate invalid urls
    tmp.delete_if {|url| !valid_url?(url)}
    # Eliminate ursl that are to short
    tmp.delete_if {|url| url.length < 12}
    Rails.logger.debug "PARSER: Returning valide urls #{tmp}" if Rails.logger.debug?
    return tmp
  end

  def valid_url?(url)
    schemes = %w(http https)
    parsed = Addressable::URI.parse(url) or return false
    schemes.include?(parsed.scheme)
  rescue Addressable::URI::InvalidURIError
    false
  end

  #Deletes last point (End of sentence)
  def delete_endpoint(tmp)
    if !(tmp.nil? or tmp.empty?)
      tmp.map! { |url|
        if !(url.nil? or url.empty?) and !url.last.match(/[[:alnum:]]$/) # regex: last char is alphabetic or numeric
          url[0...-1]
        else
          url
        end
      }
      return tmp
    end
  end
  # Returns hashtag objects as array
  def get_hashtags(tweet)
    hashtags_object_array = []
    hashtags_string_array = parse_hashtags(tweet)
    hashtags_string_array.each do |tag|
      if Hashtag.where(text: tag).blank?
        hashtag = Hashtag.create(text: tag)
        hashtag.create_popularity(times_used: [0])
      else
        hashtag = Hashtag.find_by_text(tag)
      end
      hashtags_object_array.push(hashtag)
    end
    return hashtags_object_array
  end

  # Returns webpage objects as array
  def get_webpages(tweet)
    webpage_object_array = []
    webpage_string_array = parse_webpages(tweet)
    webpage_string_array.each do |url|
      nailer = LinkThumbnailer.generate(url)
      if Webpage.where(url: url).blank?
        webpage = Webpage.create(
            url: url,
            title: nailer.title,
            description: nailer.description
        )
      else
        webpage = Webpage.find_by_url(url)
      end
      webpage_object_array.push(webpage)
    end
  rescue LinkThumbnailer::Exceptions => e
    Rails.logger.debug "DEBUG: Error in LinkThumbnailer" if Rails.logger.debug?
    Rails.logger.debug "DEBUG: #{self.inspect} #{caller(0).first}" if Rails.logger.debug?
    Rails.logger.debug "DEBUG: #{e.message}" if Rails.logger.debug?
  rescue Net::HTTPExceptions => e
    Rails.logger.debug "DEBUG: HTTP Error while thumbnailing" if Rails.logger.debug?
    Rails.logger.debug "DEBUG: #{self.inspect} #{caller(0).first}" if Rails.logger.debug?
    Rails.logger.debug "DEBUG: #{e.message}" if Rails.logger.debug?
  # TODO: Find the specific exception and rescue it. The current state is bad practice
  rescue Exception => e
    Rails.logger.debug "DEBUG: Unknown error while thumbnailing. Possibly ill formated url?" if Rails.logger.debug?
    Rails.logger.debug "DEBUG: #{self.inspect} #{caller(0).first}" if Rails.logger.debug?
    Rails.logger.debug "DEBUG: #{e.message}" if Rails.logger.debug?
  # Even after error: always return the webpages that have been created up to this point
  ensure
    return webpage_object_array
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