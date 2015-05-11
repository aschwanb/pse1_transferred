module SearchUtility

  def build_pair_hash(anchor, pairs)
    paired_hash = Hash.new
    pairs.each do |pair|
      pair.hashtag_first_id == anchor.id ? paired_hash.store(pair.hashtag_second, pair.get_rank)
        : paired_hash.store(pair.hashtag_first, pair.get_rank)
    end
    return paired_hash
  end

  # given a hashtag object, returns its associated pairs
  def retrieve_hashtag_pairs(hashtag)
    pairs = []
    return pairs if hashtag.blank?
    pairs.concat(HashtagHashtag.where(hashtag_first_id: hashtag.id))
    pairs.concat(HashtagHashtag.where(hashtag_second_id: hashtag.id))
    return pairs
  end

  # given an array of hashtags, returns the tweets containing all given hashtags
  def retrieve_tweets_by_hashtags(hashtags, limit=nil)
    return Array.new if hashtags.empty?
    limit.nil? ? tweets = hashtags.first.get_tweets : tweets = hashtags.first.get_tweets(limit)
    if hashtags.size > 1
      hashtags.each_with_index do |el, index|
        next if index == 0
        tweets.delete_if {|tweet| !tweet.get_hashtags.include?(el)}
      end
    end
    return tweets
  end

  def retrieve_webpages_by_tweets(tweets)
    webpages = Array.new
    tweets.each do |tweet|
      webpages.concat(tweet.get_webpages)
    end
    return webpages
  end

  # filters an array of hashtags for the trending long ones
  def filter_trending_long_hashtags(hashtags)
    return Array.new if hashtags.blank?
    return hashtags & Trending.first.get_popular_long
  end

  # filters an array of hashtags for the trending short ones
  def filter_trending_short_hashtags(hashtags)
    return Array.new if hashtags.blank?
    return hashtags & Trending.second.get_popular_short
  end

  # filters out the webpage objects that link to the same article. These have matching title and description.
  # Webpages with no title are considered valid. (Should this be changed?)
  def filter_webpages(webpages)
    return Array.new if webpages.blank?
    webpages.uniq!
    filtered_webpages = Array.new(webpages)
    controll = Array.new
    webpages.each do |page|
      controll.include?(page) ? next : controll.append(page)
      filtered_webpages = filter_for_page(page, filtered_webpages)
    end

    return filtered_webpages
  end

  def filter_for_page(page, pages)
    pages.delete_if {|p| p.get_title.eql?(page.get_title)} unless page.get_title.blank?
    pages.unshift(page)
    return pages
  end

  # unused or not yet used methods:

  # # given an array of authors, returns the tweets they wrote
  # def retrieve_tweets_by_authors(authors, limit)
  #   return Array.new if authors.empty?
  #   tweets = []
  #   authors.each do |author|
  #     tweets.concat(author.get_tweets(limit))
  #   end
  #   return tweets
  # end

  # # given two hashtags, returns their pair object or nil if no association exists
  # def retrieve_hashtag_pair_by_pair(hashtags)
  #   return nil if hashtags.blank?
  #   h1 = hashtags.first
  #   h2 = hashtags.second
  #   pair = HashtagHashtag.where(hashtag_first_id: h1.id, hashtag_second_id: h2.id)
  #   pair = HashtagHashtag.where(hashtag_first_id: h2.id, hashtag_second_id: h1.id) if pair.nil?
  #   return pair
  # end



end
