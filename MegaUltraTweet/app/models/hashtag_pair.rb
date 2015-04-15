class HashtagPair < ActiveRecord::Base
  belongs_to :hashtag_first, class_name: :Hashtag, foreign_key: :hashtag_first_id
  belongs_to :hashtag_second, class_name: :Hashtag, foreign_key: :hashtag_second_id

  def get_popularity_now
    return self.popularity_now
  end

  def get_popularity_old
    return self.populairity_old
  end

end