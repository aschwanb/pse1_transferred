
# refactor this!
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

  def isValid?
    return @searchValid
  end

  def setSearchSuccessful
    @searchSuccessful = true
  end

  def isSuccessful?
    return @searchSuccessful
  end

  def addTweets(tweets)
    @tweets.append(tweets)
  end

  def setTweets(tweets)

    # create an sorted array with author names (string)
    authorNames = []
    hashtags = []
    hashtagText = []
    tweets.each do |tweet|
      authorNames.append(tweet.getAuthor.getName)
      hashtags.concat(tweet.getHashtags)
    end
    count = Hash.new(0)
    authorNames.each {|element| count[element] += 1}
    authorNames = authorNames.uniq.sort {|x,y| count[y] <=> count[x]}
    self.setAuthorsSorted(authorNames)

    # create an sorted array with hashtags (string)
    hashtags = hashtags.flatten
    hashtags.each do |hashtag|
      hashtagText.append(hashtag.getText)
    end
    count = Hash.new(0)
    hashtagText.each {|element| count[element] += 1}
    hashtagText = hashtagText.uniq.sort {|x,y| count[y] <=> count[x]}
    self.setHashtagsSorted(hashtagText)

    count = Hash.new(0)
    tweets.each {|element| count[element] += 1}
    tweets = tweets.uniq.sort {|x,y| count[y] <=> count[x]}
    @tweets = tweets
  end

  def getTweets
    return @tweets
  end

  def addSearchTerms(terms)
    @searchTerms += terms
  end

  def getSearchTerms
    return @searchTerms
  end

  def setHashtags(hashtags)
    @hashtags = hashtags
  end

  def getHashtags
    return @hashtags
  end

  def setAuthors(authors)
    @authors = authors
  end

  def getAuthors
    return @authors
  end

  # takes an unique array of strings sorted by occurrence
  def setAuthorsSorted(authors)
    @authorsSorted = authors
  end

  # returns an unique array of strings containing author names sorted by occurrence
  def getAuthorsSorted
    return @authorsSorted
  end

  def setHashtagsSorted(hashtags)
    @hashtagsSorted = hashtags
  end

  def getHashtagsSorted
    return @hashtagsSorted
  end

end