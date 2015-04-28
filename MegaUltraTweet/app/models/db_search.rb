require 'search_object'
require 'link_thumbnailer'
class DbSearch

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

  def continuous_search(hashtags, anchor)
    cont_sobjs = []
    hashtags = hashtags.scan(/\w+/).flatten
    hashtags.each do |hashtag|
      search_terms = Array.new
      search_terms.append(anchor)
      search_terms.append(hashtag)
      cont_sobjs.append(evaluate(multi_search(search_terms, SearchObject.new(search_terms))))
    end
    return cont_sobjs
  end

  private

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

  def evaluate(search_object)
    return search_object unless search_object.is_valid?
    authors = search_object.get_criteria_authors
    hashtags = search_object.get_criteria_hashtags
    tweets = []

    # only hashtags as search criteria, AND relation condition between hashtags
    if authors.empty?
      tweets = retrieve_tweets_by_hashtags(hashtags, @limit)
    # only authors as search criteria, OR relation condition
    elsif hashtags.empty?
      tweets = retrieve_tweets_by_authors(authors, @limit)
    # both hashtags and authors as search criteria, (AND{hashtags}) AND (OR{authors})
    else
      tweets_by_hashtags = retrieve_tweets_by_hashtags(hashtags, @limit)
      tweets_by_authors = retrieve_tweets_by_authors(authors, @limit)
      # get common elements between the arrays (Intersection)
      tweets = tweets_by_hashtags & tweets_by_authors
    end

    #Get relevant records and sort them by popularity (rank)
    rel_authors = []
    rel_hashtags = []
    webpages = []

    sorter = Sorter.new
    tweets = sorter.sort_by_rank(tweets)

    tweets.each do |tweet|
      rel_authors.append(tweet.get_author)
      rel_hashtags.concat(tweet.get_hashtags)
      webpages.concat(tweet.get_webpages)
    end

    rel_hashtags.delete_if { |hashtag| hashtags.include?(hashtag)}

    rel_authors = sorter.sort_by_rank(rel_authors)
    rel_hashtags = sorter.sort_by_popularity(rel_hashtags)

    search_object.set_tweets(tweets)
    search_object.set_authors(rel_authors)
    search_object.set_hashtags(rel_hashtags)
    search_object.set_webpages(webpages)
    return search_object
  end

  # given an array of hashtags, returns the tweets containing all given hashtags
  def retrieve_tweets_by_hashtags(hashtags, limit)
    return Array.new if hashtags.empty?
    # tweets = []
    # tweets.append(Tweet.joins(:hashtags).where(hashtags: {:id => hashtags.first.id}).order(retweets: :DESC).limit(limit))
    tweets = hashtags.first.get_tweets(limit)
    hashtags.each do |hashtag|
      tweets.delete_if { |tweet| !tweet.get_hashtags.include?(hashtag)}
    end
    return tweets
  end

  # given an array of authors, returns the tweets they wrote
  def retrieve_tweets_by_authors(authors, limit)
    return Array.new if authors.empty?
    tweets = []
    authors.each do |author|
      tweets.concat(author.get_tweets(limit))
    end
    return tweets
  end

  def retrieve_hashtag_pairs(hashtags)
    return Array.new if hashtags.empty?
    pairs = []
    hashtags.each do |hashtag|
      pairs.concat(HashtagPair.where(:hashtag_first_id => hashtag.id).order(popularity_now: :desc).limit(30))
      # pairs.concat(HashtagPair.where(:hashtag_second_id => hashtag.id).order(popularity_now: :desc).limit(30))
    end
    return pairs
  end

  def get_hashtags_from_pairs(pairs)
    return Array.new if pairs.empty?
    hashtags = []
    pairs.each do |pair|
      hashtags.append(pair.hashtag_first)
      hashtags.append(pair.hashtag_second)
    end
    return hashtags.uniq
  end

end