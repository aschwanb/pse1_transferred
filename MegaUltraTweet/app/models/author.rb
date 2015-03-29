class Author < ActiveRecord::Base
  has_many :tweets

  def getName
    return self.name
  end
end
