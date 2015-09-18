class Series < ActiveRecord::Base
  has_many :posts

  before_save :write_permalink

  scope :containing_posts, -> {
    distinct("posts.id").
      joins("JOIN posts ON posts.series_id = series.id")
  }

  def containing_posts_count
    containing_posts.count("DISTINCT series.id")
  end

  def to_s
    name
  end

  def self.fuzzy(id)
    by_id = find_by(id: id)
    return by_id if by_id
    find_by(permalink: id)
  end

private

  def write_permalink
    return if permalink.present?
    write_attribute(:permalink, name.parameterize)
  end

end
