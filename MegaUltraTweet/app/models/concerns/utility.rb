module Utility

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

  # filters an array of hashtags for the trending ones
  def filter_trending_hashtags(hashtags)
    return Array.new if hashtags.blank?
    return hashtags & Trending.first.get_popular_long
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
