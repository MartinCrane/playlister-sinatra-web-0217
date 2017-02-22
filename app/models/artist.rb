
class Artist < ActiveRecord::Base

  has_many :songs
  has_many :genres, through: :songs

  include Slug

  def self.find_by_slug(slug)

    self.all.find{|x| x.slug == slug}

  end
end
