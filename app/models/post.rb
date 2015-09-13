class Post < ActiveRecord::Base
  belongs_to :author
  belongs_to :category

  scope :ordered, -> {
    order( created_at: :desc )
  }

  scope :published, -> {
    where('posts.published_at <= NOW()')
  }

  scope :homepage, -> {
    published.ordered.limit(6)
  }

  def self.fuzzy(id)
    by_id = find_by(id: id)
    return by_id if by_id
    find_by(permalink: id)
  end

  def publish=(val)
    write_attribute(:published_at, DateTime.now) if val
  end

  def author_url
    author && author.url
  end

  def author_name
    author && author.name
  end

  def author_avatar
    author && author.gravatar_url
  end

  def category_name
    category.name
  end

  def published?
    published_at.present? &&
      published_at <= DateTime.now
  end

  def title=(val)
    write_attribute(:title, val)
    return if permalink.present?
    write_attribute(:permalink, val.parameterize)
  end

  def markdown=(val)
    write_attribute(:markdown, val)
    write_attribute(:html, to_html(val))
  end

private

  def to_html(val)
    require 'no_follow_filter'
    require 'responsive_images_filter'
    pipeline = HTML::Pipeline.new([
      HTML::Pipeline::MarkdownFilter,
      NoFollowFilter,
      ResponsiveImagesFilter,
    ], gfm: true)
    pipeline.call(val)[:output].to_s
  end
end
