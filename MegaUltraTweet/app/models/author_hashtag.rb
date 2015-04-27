class AuthorHashtag < ActiveRecord::Base
  belongs_to :author
  belongs_to :hashtag
  has_one :popularity, as: :popular

end
