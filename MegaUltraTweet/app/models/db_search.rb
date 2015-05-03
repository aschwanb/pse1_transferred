require 'search_object'
require 'link_thumbnailer'
class DbSearch
  include Utility

  @limit

  def initialize
    @limit = 500
  end

  def parse_query(query)
    query = query.to_s.downcase

    # Create array with the search terms
    search_terms = query.scan(/\w+/).flatten
    # Consider only 2 search terms
    search_terms = search_terms.take(2) if search_terms.size > 2

    search_object = multi_search(search_terms, SearchObject.new(search_terms))
    search_object = evaluate(search_object)
    return search_object
  end

  def single_search(search_term, search_object)
    # some authors have hashtags as screen name but no hashtag starts with '@'...

    # screen names are saved without '@' in the DB
    search_term.chr =~ /@/ ? term = search_term.slice(1, search_term.length) : term = search_term
    # author = Author.by_screen_name(term)
    author = Author.find_by_screen_name(term)

    # hashtags are saved with '#' in the DB
    search_term.chr =~ /#/ ? term = search_term : term = "#".concat(search_term)
    # hashtag = Hashtag.by_hashtag(term)
    hashtag = Hashtag.find_by_text(term)

    search_object.add_criterion_author(author) unless author.nil?
    search_object.add_criterion_hashtag(hashtag) unless hashtag.nil?

    return search_object
  end

  def multi_search(search_terms, search_object)
    return search_object unless search_object.is_valid?
    sobj = search_object
    search_terms.each do |term|
      sobj = single_search(term.to_s, sobj)
    end
    return sobj
  end

  # def search_with_hashtag_pair(hashtags)
  #   hashtags.each do |h|
  #     pairs = retrieve_hashtag_pairs(h)
  #     paired_hash = build_pair_hash(h, pairs)
  #     search_object.set_paired_hashtags(h, paired_hash)
  #   end
  # end

  def evaluate(search_object)
    return search_object unless search_object.is_valid?
    authors = search_object.get_criteria_authors
    hashtags = search_object.get_criteria_hashtags
    return search_object if authors.blank? && hashtags.blank?

    tweets = []
    sorter = Sorter.new

    # only hashtags as search criteria, AND relation condition between hashtags
    if authors.empty?
      tweets = retrieve_tweets_by_hashtags(hashtags, @limit)
      # hashtags have been found but are not actively used
      return search_object.set_search_deprecated if tweets.blank? && !hashtags.blank?
      return search_object if tweets.blank?

      hashtags.each do |h|
        pairs = retrieve_hashtag_pairs(h)
        pairs = sorter.sort_by_rank(pairs)
        paired_hash = build_pair_hash(h, pairs)
        search_object.set_paired_hashtags(h, paired_hash)
      end

      # # search for hashtag pair
      # if hashtags.size == 2
      #   pair = retrieve_hashtag_pair_by_pair(hashtags)
      #   h1_pairs = retrieve_hashtag_pairs(hashtags.first)
      #   h2_pairs = retrieve_hashtag_pairs(hashtags.last)
      #   h1_paired_hash = build_pair_hash(hashtags.first, h1_pairs)
      #   h2_paired_hash = build_pair_hash(hashtags.last, h2_pairs)
      #
      # # search for one hashtag
      # else
      #   pairs = retrieve_hashtag_pairs(hashtags.first)
      #
      #   # TODO: may be not necessary to sort
      #   pairs = sorter.sort_by_rank(pairs)
      #   paired_hash = build_pair_hash(hashtags.first, pairs)
      #
      # end

    # only authors as search criteria, OR relation condition

    # disabled author search for now

    # else hashtags.empty?
    #   tweets = retrieve_tweets_by_authors(authors, @limit)

    # disabled combined search for now

    # both hashtags and authors as search criteria, (AND{hashtags}) AND (OR{authors})
    # else
    #   tweets_by_hashtags = retrieve_tweets_by_hashtags(hashtags, @limit)
    #   tweets_by_authors = retrieve_tweets_by_authors(authors, @limit)
    #   # get common elements between the arrays (Intersection)
    #   tweets = tweets_by_hashtags & tweets_by_authors
    end

    #Get relevant records and sort them by popularity (rank)
    webpages = []
    tweets = sorter.sort_by_rank(tweets)
    tweets.take(100).each do |tweet|
      webpages.concat(tweet.get_webpages)
    end
    webpages.uniq!

    search_object.set_webpages(webpages)
    search_object.set_search_successful
    return search_object
  end

  # given an array of hashtags, returns the tweets containing all given hashtags
  def retrieve_tweets_by_hashtags(hashtags, limit)
    return Array.new if hashtags.empty?
    # tweets = []
    # tweets.append(Tweet.joins(:hashtags).where(hashtags: {:id => hashtags.first.id}).order(retweets: :DESC).limit(limit))
    tweets = hashtags.first.get_tweets(limit)
    if hashtags.size > 1
      hashtags.each_with_index do |el, index|
        next if index == 0
        tweets.delete_if {|tweet| !tweet.get_hashtags.include?(el)}
      end
    end
    return tweets
  end

  # # given an array of authors, returns the tweets they wrote
  # def retrieve_tweets_by_authors(authors, limit)
  #   return Array.new if authors.empty?
  #   tweets = []
  #   authors.each do |author|
  #     tweets.concat(author.get_tweets(limit))
  #   end
  #   return tweets
  # end

  # given a hashtag object, returns its associated pairs
  def retrieve_hashtag_pairs(hashtag)
    pairs = []
    return pairs if hashtag.blank?
    pairs.concat(HashtagHashtag.where(hashtag_first_id: hashtag.id))
    pairs.concat(HashtagHashtag.where(hashtag_second_id: hashtag.id))
    return pairs
  end

  # # given two hashtags, returns their pair object or nil if no association exists
  # def retrieve_hashtag_pair_by_pair(hashtags)
  #   return nil if hashtags.blank?
  #   h1 = hashtags.first
  #   h2 = hashtags.second
  #   pair = HashtagHashtag.where(hashtag_first_id: h1.id, hashtag_second_id: h2.id)
  #   pair = HashtagHashtag.where(hashtag_first_id: h2.id, hashtag_second_id: h1.id) if pair.nil?
  #   return pair
  # end

  # def get_hashtags_from_pairs(pairs)
  #   return Array.new if pairs.empty?
  #   hashtags = []
  #   pairs.each do |pair|
  #     hashtags.append(pair.hashtag_first)
  #     hashtags.append(pair.hashtag_second)
  #   end
  #   return hashtags.uniq
  # end

end