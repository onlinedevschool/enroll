class Post < ActiveRecord::Base
  belongs_to :author
  belongs_to :category
  belongs_to :series

  scope :ordered, -> {
    order( created_at: :desc )
  }

  scope :published, -> {
    where('posts.published_at <= NOW()')
  }

  scope :homepage, -> {
    published.ordered.limit(6)
  }

  before_create :write_permalink
  before_save   :write_html

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

  def markdown=(val)
    write_attribute(:markdown, val)
  end

  def full_title
    if series
      [series, title].join(" - ")
    else
      title
    end
  end

private

  def write_permalink
    generated = [series.to_s, read_attribute(:title)].
      join(" ").
      parameterize
    write_attribute(:permalink, generated)
  end

  def write_html
    require 'no_follow_filter'
    require 'responsive_images_filter'
    require 'pygments'
    pipeline = HTML::Pipeline.new([
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::SyntaxHighlightFilter,
      NoFollowFilter,
      ResponsiveImagesFilter,
    ], gfm: true)

    html = pipeline.call(read_attribute(:markdown))[:output].to_s
    write_attribute(:html, html)
  end
end
