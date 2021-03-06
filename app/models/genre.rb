
class Genre < ActiveRecord::Base
  has_many :song_genres
  has_many :songs, through: :song_genres
  has_many :artists, through: :songs

  include Slug

  def self.find_by_slug(slug)

    self.all.find{|x| x.slug == slug}
    
  end

end
