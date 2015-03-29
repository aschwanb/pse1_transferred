class Webpage < ActiveRecord::Base
  belongs_to :tweet

  def getUrl
    return self.url
  end
end
