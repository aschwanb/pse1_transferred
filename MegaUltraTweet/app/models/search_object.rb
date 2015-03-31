
# TODO: refactor this!
class SearchObject
  @searchSuccessful
  @searchValid
  @searchTerms = []
  @tweets = []
  @hashtags
  @authors = []
  @authorsSorted
  @hashtagsSorted

  def initialize(query)
    @searchTerms = query
    @searchTerms.empty? ? @searchValid = false : @searchValid = true
    @searchSuccessful = false
  end

  def is_valid?
    return @searchValid
  end

  def set_search_successful
    @searchSuccessful = true
  end

  def is_successful?
    return @searchSuccessful
  end

  def add_tweets(tweets)
    @tweets.append(tweets)
  end

  def set_tweets(tweets)

    # create an sorted array with author names (string)
    authorNames = []
    hashtags = []
    hashtagText = []
    tweets.each do |tweet|
      authorNames.append(tweet.get_author.getName)
      hashtags.concat(tweet.get_hashtags)
    end
    count = Hash.new(0)
    authorNames.each {|element| count[element] += 1}
    authorNames = authorNames.uniq.sort {|x,y| count[y] <=> count[x]}
    self.set_authors_sorted(authorNames)

    # create an sorted array with hashtags (string)
    hashtags = hashtags.flatten
    hashtags.each do |hashtag|
      hashtagText.append(hashtag.get_text)
    end
    count = Hash.new(0)
    hashtagText.each {|element| count[element] += 1}
    hashtagText = hashtagText.uniq.sort {|x,y| count[y] <=> count[x]}
    self.set_hashtags_sorted(hashtagText)

    count = Hash.new(0)
    tweets.each {|element| count[element] += 1}
    tweets = tweets.uniq.sort {|x,y| count[y] <=> count[x]}
    @tweets = tweets
  end

  def get_tweets
    return @tweets
  end

  def add_search_terms(terms)
    @searchTerms += terms
  end

  def get_search_terms
    return @searchTerms
  end

  def set_hashtags(hashtags)
    @hashtags = hashtags
  end

  def get_hashtags
    return @hashtags
  end

  def set_authors(authors)
    @authors = authors
  end

  def get_authors
    return @authors
  end

  # takes an unique array of strings sorted by occurrence
  def set_authors_sorted(authors)
    @authorsSorted = authors
  end

  # returns an unique array of strings containing author names sorted by occurrence
  def get_authors_sorted
    return @authorsSorted
  end

  def set_hashtags_sorted(hashtags)
    @hashtagsSorted = hashtags
  end

  def get_hashtags_sorted
    return @hashtagsSorted
  end

end